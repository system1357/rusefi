/**
 * @file	can_hw.cpp
 * @brief	CAN bus low level code
 *
 * todo: this file should be split into two - one for CAN transport level ONLY and
 * another one with actual messages
 *
 * @see can_verbose.cpp for higher level logic
 * @see obd2.cpp for OBD-II messages via CAN
 *
 * @date Dec 11, 2013
 * @author Andrey Belomutskiy, (c) 2012-2020
 */

#include "global.h"

#if EFI_CAN_SUPPORT

#include "can.h"
#include "engine_configuration.h"
#include "pin_repository.h"
#include "can_hw.h"
#include "can_msg_tx.h"
#include "string.h"
#include "mpu_util.h"
#include "engine.h"

EXTERN_ENGINE;

static int canReadCounter = 0;
int canWriteOk = 0;
int canWriteNotOk = 0;
static bool isCanEnabled = false;
static LoggingWithStorage logger("CAN driver");

// Values below calculated with http://www.bittiming.can-wiki.info/
// Pick ST micro bxCAN
// Clock rate of 42mhz for f4, 54mhz for f7
#ifdef STM32F4XX
// These have an 85.7% sample point
#define CAN_BTR_100 (CAN_BTR_SJW(0) | CAN_BTR_BRP(29) | CAN_BTR_TS1(10) | CAN_BTR_TS2(1))
#define CAN_BTR_250 (CAN_BTR_SJW(0) | CAN_BTR_BRP(11) | CAN_BTR_TS1(10) | CAN_BTR_TS2(1))
#define CAN_BTR_500 (CAN_BTR_SJW(0) | CAN_BTR_BRP(5)  | CAN_BTR_TS1(10) | CAN_BTR_TS2(1))
#define CAN_BTR_1k0 (CAN_BTR_SJW(0) | CAN_BTR_BRP(2)  | CAN_BTR_TS1(10) | CAN_BTR_TS2(1))
#elif defined(STM32F7XX)
// These have an 88.9% sample point
#define CAN_BTR_100 (CAN_BTR_SJW(0) | CAN_BTR_BRP(30) | CAN_BTR_TS1(15) | CAN_BTR_TS2(2))
#define CAN_BTR_250 (CAN_BTR_SJW(0) | CAN_BTR_BRP(11) | CAN_BTR_TS1(14) | CAN_BTR_TS2(1))
#define CAN_BTR_500 (CAN_BTR_SJW(0) | CAN_BTR_BRP(5)  | CAN_BTR_TS1(14) | CAN_BTR_TS2(1))
#define CAN_BTR_1k0 (CAN_BTR_SJW(0) | CAN_BTR_BRP(2)  | CAN_BTR_TS1(14) | CAN_BTR_TS2(1))
#else
#error Please define CAN BTR settings for your MCU!
#endif

/*
 * 500KBaud
 * automatic wakeup
 * automatic recover from abort mode
 * See section 22.7.7 on the STM32 reference manual.
 * 
 * 29 bit would be CAN_TI0R_EXID (?) but we do not mention it here
 * CAN_TI0R_STID "Standard Identifier or Extended Identifier"? not mentioned as well
 */

static const CANConfig canConfig100 = {
CAN_MCR_ABOM | CAN_MCR_AWUM | CAN_MCR_TXFP,
CAN_BTR_100 };

static const CANConfig canConfig250 = {
CAN_MCR_ABOM | CAN_MCR_AWUM | CAN_MCR_TXFP,
CAN_BTR_250 };

static const CANConfig canConfig500 = {
CAN_MCR_ABOM | CAN_MCR_AWUM | CAN_MCR_TXFP,
CAN_BTR_500 };

static const CANConfig canConfig1000 = {
CAN_MCR_ABOM | CAN_MCR_AWUM | CAN_MCR_TXFP,
CAN_BTR_1k0 };

static const CANConfig *canConfig = &canConfig500;

class CanRead final : public ThreadController<UTILITY_THREAD_STACK_SIZE> {
public:
	CanRead()
		: ThreadController("CAN RX", NORMALPRIO)
	{
	}

	void ThreadTask() override {
		CANDriver* device = detectCanDevice(CONFIG_OVERRIDE(canRxPin), CONFIG_OVERRIDE(canTxPin));

		if (!device) {
			warning(CUSTOM_ERR_CAN_CONFIGURATION, "CAN configuration issue");
			return;
		}

		while (true) {
			// Block until we get a message
			msg_t result = canReceiveTimeout(device, CAN_ANY_MAILBOX, &m_buffer, TIME_INFINITE);

			if (result != MSG_OK) {
				continue;
			}

			// Process the message
			canReadCounter++;

			processCanRxMessage(m_buffer, &logger, getTimeNowNt());
		}
	}

private:
	CANRxFrame m_buffer;
};

static CanRead canRead;
static CanWrite canWrite;

static void canInfo(void) {
	if (!isCanEnabled) {
		scheduleMsg(&logger, "CAN is not enabled, please enable & restart");
		return;
	}

	scheduleMsg(&logger, "CAN TX %s", hwPortname(CONFIG_OVERRIDE(canTxPin)));
	scheduleMsg(&logger, "CAN RX %s", hwPortname(CONFIG_OVERRIDE(canRxPin)));
	scheduleMsg(&logger, "type=%d canReadEnabled=%s canWriteEnabled=%s period=%d", engineConfiguration->canNbcType,
			boolToString(engineConfiguration->canReadEnabled), boolToString(engineConfiguration->canWriteEnabled),
			engineConfiguration->canSleepPeriodMs);

	scheduleMsg(&logger, "CAN rx_cnt=%d/tx_ok=%d/tx_not_ok=%d", canReadCounter, canWriteOk, canWriteNotOk);
}

void setCanType(int type) {
	engineConfiguration->canNbcType = (can_nbc_e)type;
	canInfo();
}

#if EFI_TUNER_STUDIO
void postCanState(TunerStudioOutputChannels *tsOutputChannels) {
	tsOutputChannels->debugIntField1 = isCanEnabled ? canReadCounter : -1;
	tsOutputChannels->debugIntField2 = isCanEnabled ? canWriteOk : -1;
	tsOutputChannels->debugIntField3 = isCanEnabled ? canWriteNotOk : -1;
}
#endif /* EFI_TUNER_STUDIO */

void enableFrankensoCan(DECLARE_ENGINE_PARAMETER_SIGNATURE) {
	CONFIG(canTxPin) = GPIOB_6;
	CONFIG(canRxPin) = GPIOB_12;
	engineConfiguration->canReadEnabled = false;
}

// this is related to #1375
static brain_pin_e currentTxPin = GPIO_UNASSIGNED;
static brain_pin_e currentRxPin = GPIO_UNASSIGNED;

void stopCanPins(DECLARE_ENGINE_PARAMETER_SIGNATURE) {
	brain_pin_markUnused(currentTxPin);
	brain_pin_markUnused(currentRxPin);
}

void startCanPins(DECLARE_ENGINE_PARAMETER_SIGNATURE) {
	// Store pins so we can disable later
	currentTxPin = CONFIG_OVERRIDE(canTxPin);
	currentRxPin = CONFIG_OVERRIDE(canRxPin);

	efiSetPadMode("CAN TX", currentTxPin, PAL_MODE_ALTERNATE(EFI_CAN_TX_AF));
	efiSetPadMode("CAN RX", currentRxPin, PAL_MODE_ALTERNATE(EFI_CAN_RX_AF));
}

void initCan(void) {
	addConsoleAction("caninfo", canInfo);

	isCanEnabled = 
		(CONFIG_OVERRIDE(canTxPin) != GPIO_UNASSIGNED) && // both pins are set...
		(CONFIG_OVERRIDE(canRxPin) != GPIO_UNASSIGNED) &&
		(CONFIG(canWriteEnabled) || CONFIG(canReadEnabled)) ; // ...and either read or write is enabled

	// nothing to do if we aren't enabled...
	if (!isCanEnabled) {
		return;
	}

	// Validate pins
	if (!isValidCanTxPin(CONFIG_OVERRIDE(canTxPin))) {
		firmwareError(CUSTOM_OBD_70, "invalid CAN TX %s", hwPortname(CONFIG_OVERRIDE(canTxPin)));
		return;
	}

	if (!isValidCanRxPin(CONFIG_OVERRIDE(canRxPin))) {
		firmwareError(CUSTOM_OBD_70, "invalid CAN RX %s", hwPortname(CONFIG_OVERRIDE(canRxPin)));
		return;
	}

	switch (CONFIG(canBaudRate)) {
	case B100KBPS:
		canConfig = &canConfig100;
		break;
	case B250KBPS:
		canConfig = &canConfig250;
		break;
	case B500KBPS:
		canConfig = &canConfig500;
		break;
	case B1MBPS:
		canConfig = &canConfig1000;
		break;
	default:
		break;
	}

	// Initialize hardware
#if STM32_CAN_USE_CAN2
	// CAN1 is required for CAN2
	canStart(&CAND1, canConfig);
	canStart(&CAND2, canConfig);
#else
	canStart(&CAND1, canConfig);
#endif /* STM32_CAN_USE_CAN2 */

	// Plumb CAN device to tx system
	CanTxMessage::setDevice(detectCanDevice(
		CONFIG_OVERRIDE(canRxPin),
		CONFIG_OVERRIDE(canTxPin)
	));

	// fire up threads, as necessary
	if (CONFIG(canWriteEnabled)) {
		canWrite.setPeriod(CONFIG(canSleepPeriodMs));
		canWrite.Start();
	}

	if (CONFIG(canReadEnabled)) {
		canRead.Start();
	}

	startCanPins();
}

#endif /* EFI_CAN_SUPPORT */
