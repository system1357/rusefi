#include "engine_test_helper.h"
#include "engine_controller.h"
#include "launch_control.h"
#include "vehicle_speed.h"

#include <gtest/gtest.h>

TEST(LaunchControl, TpsCondition) {
	WITH_ENGINE_TEST_HELPER(TEST_ENGINE);

	LaunchControlBase dut;
	INJECT_ENGINE_REFERENCE(&dut);

	engineConfiguration->launchTpsTreshold = 10;

	// Should return false with failed sensor
	Sensor::resetMockValue(SensorType::DriverThrottleIntent);
	EXPECT_FALSE(dut.isInsideTpsCondition());

	// Should return false when throttle is closed
	Sensor::setMockValue(SensorType::DriverThrottleIntent, 5.0f);
	EXPECT_FALSE(dut.isInsideTpsCondition());
	
	// Should return true when throttle is opened past the threshold
	Sensor::setMockValue(SensorType::DriverThrottleIntent, 20.0f);
	EXPECT_TRUE(dut.isInsideTpsCondition());
}


TEST(LaunchControl, VSSCondition) {
	WITH_ENGINE_TEST_HELPER(TEST_ENGINE);

	LaunchControlBase dut;
	INJECT_ENGINE_REFERENCE(&dut);

	// Test Speed trashold
    engineConfiguration->launchSpeedTreshold = 30; 
	engineConfiguration->launchDisableBySpeed = 1;
	setMockVehicleSpeed(10);
    EXPECT_TRUE(dut.isInsideSpeedCondition());

	setMockVehicleSpeed(40);
	EXPECT_FALSE(dut.isInsideSpeedCondition());

	//we do not want to disable launch by speed
    engineConfiguration->launchSpeedTreshold = 30; 
	engineConfiguration->launchDisableBySpeed = 0;

	setMockVehicleSpeed(10.0);
    EXPECT_TRUE(dut.isInsideSpeedCondition());

	setMockVehicleSpeed(40.0);
	EXPECT_TRUE(dut.isInsideSpeedCondition());
}

TEST(LaunchControl, RPMCondition) {
	WITH_ENGINE_TEST_HELPER(TEST_ENGINE);

	LaunchControlBase dut;
	INJECT_ENGINE_REFERENCE(&dut);

	engineConfiguration->launchRpm = 3000;

	EXPECT_FALSE(dut.isInsideRPMCondition(2900));

	EXPECT_TRUE(dut.isInsideRPMCondition(3100));
}

TEST(LaunchControl, SwitchInputCondition) {
	WITH_ENGINE_TEST_HELPER(TEST_ENGINE);

	LaunchControlBase dut;
	INJECT_ENGINE_REFERENCE(&dut);

	//activation based on VSS
	engineConfiguration->launchActivationMode=ALWAYS_ACTIVE_LAUNCH;
	EXPECT_TRUE(dut.isInsideSwitchCondition());

	//active by switch
	engineConfiguration->launchActivationMode=SWITCH_INPUT_LAUNCH;
	engineConfiguration->launchActivatePin = GPIOG_1;
	setMockState(engineConfiguration->launchActivatePin, true);
	EXPECT_TRUE(dut.isInsideSwitchCondition());

	setMockState(engineConfiguration->launchActivatePin, false);
	EXPECT_FALSE(dut.isInsideSwitchCondition());

	//by clutch
	engineConfiguration->launchActivationMode=CLUTCH_INPUT_LAUNCH;
	engineConfiguration->clutchDownPin = GPIOG_2;
	engineConfiguration->clutchDownPinMode = PI_PULLUP;
	setMockState(engineConfiguration->clutchDownPin, true);
	EXPECT_TRUE(dut.isInsideSwitchCondition());

	setMockState(engineConfiguration->clutchDownPin, false);
	EXPECT_FALSE(dut.isInsideSwitchCondition());

	engineConfiguration->clutchDownPinMode = PI_PULLDOWN;
	setMockState(engineConfiguration->clutchDownPin, false);
	EXPECT_TRUE(dut.isInsideSwitchCondition());

	setMockState(engineConfiguration->clutchDownPin, true);
	EXPECT_FALSE(dut.isInsideSwitchCondition());

}

TEST(LaunchControl, CombinedCondition) {
	WITH_ENGINE_TEST_HELPER(TEST_ENGINE);

	LaunchControlBase dut;
	INJECT_ENGINE_REFERENCE(&dut);

	//check VSS normal usage
	engineConfiguration->launchActivationMode=ALWAYS_ACTIVE_LAUNCH;
    engineConfiguration->launchSpeedTreshold = 30; 
	engineConfiguration->launchDisableBySpeed = 1;
	engineConfiguration->launchRpm = 3000;
	engineConfiguration->launchTpsTreshold = 10;
	//valid TPS
	Sensor::setMockValue(SensorType::DriverThrottleIntent, 20.0f);
	
	setMockVehicleSpeed(10);
	engine->rpmCalculator.mockRpm = 1200;

    EXPECT_FALSE(dut.isLaunchConditionMet(1200));

	engine->rpmCalculator.mockRpm = 3200;
	EXPECT_TRUE(dut.isLaunchConditionMet(3200));

	setMockVehicleSpeed(40);
	EXPECT_FALSE(dut.isLaunchConditionMet(3200));

}
