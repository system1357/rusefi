EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:1123038-2
LIBS:logo
LIBS:logo_flipped
LIBS:1123038-2-cache
EELAYER 25 0
EELAYER END
$Descr A 8500 11000 portrait
encoding utf-8
Sheet 1 1
Title "ECU adapter"
Date "2017-03-19"
Rev "R0.4"
Comp "DAECU for rusEFI"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_01X01 P1
U 1 1 5374C241
P 750 9925
F 0 "P1" V 830 9925 40  0000 L CNN
F 1 "CONN_1" H 750 9980 30  0001 C CNN
F 2 "1pin" H 750 9925 60  0001 C CNN
F 3 "" H 750 9925 60  0000 C CNN
	1    750  9925
	0    -1   -1   0   
$EndComp
$Comp
L CONN_01X01 P2
U 1 1 5374C093
P 950 9925
F 0 "P2" V 1030 9925 40  0000 L CNN
F 1 "CONN_1" H 950 9980 30  0001 C CNN
F 2 "1pin" H 950 9925 60  0001 C CNN
F 3 "" H 950 9925 60  0000 C CNN
	1    950  9925
	0    -1   -1   0   
$EndComp
Connection ~ 950  10125
Wire Wire Line
	1550 10125 1550 10275
Text Label 1150 10125 0    60   ~ 0
GND
Wire Wire Line
	750  10125 1550 10125
$Comp
L GND #PWR01
U 1 1 5374C132
P 1550 10275
F 0 "#PWR01" H 1550 10275 30  0001 C CNN
F 1 "GND" H 1550 10205 30  0001 C CNN
F 2 "" H 1550 10275 60  0000 C CNN
F 3 "" H 1550 10275 60  0000 C CNN
	1    1550 10275
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG02
U 1 1 57F187BE
P 1550 10125
F 0 "#FLG02" H 1550 10220 50  0001 C CNN
F 1 "PWR_FLAG" H 1550 10305 50  0000 C CNN
F 2 "" H 1550 10125 50  0000 C CNN
F 3 "" H 1550 10125 50  0000 C CNN
	1    1550 10125
	1    0    0    -1  
$EndComp
$Comp
L 1123038-2 P10
U 1 1 57F1B83D
P 4400 2625
F 0 "P10" V 6150 3775 50  0000 C CNN
F 1 "1123038-2" V 6150 2325 50  0000 C CNN
F 2 "1123038-2" V 6150 1625 50  0001 C CNN
F 3 "DOCUMENTATION" V 6150 3225 50  0001 C CNN
	1    4400 2625
	0    -1   -1   0   
$EndComp
$Comp
L CONN_01X06 P5
U 1 1 57F1BCB0
P 3050 4225
F 0 "P5" H 3050 4575 50  0000 C CNN
F 1 "CONN_01X06" V 3150 4225 50  0001 C CNN
F 2 "Molex_NanoFit_1x06x2.50mm_Straight" H 3050 4225 50  0001 C CNN
F 3 "" H 3050 4225 50  0000 C CNN
	1    3050 4225
	0    -1   1    0   
$EndComp
$Comp
L CONN_01X06 P14
U 1 1 57F1BF4F
P 5250 4225
F 0 "P14" H 5250 4575 50  0000 C CNN
F 1 "CONN_01X06" V 5350 4225 50  0001 C CNN
F 2 "Molex_NanoFit_1x06x2.50mm_Straight" H 5250 4225 50  0001 C CNN
F 3 "" H 5250 4225 50  0000 C CNN
	1    5250 4225
	0    -1   1    0   
$EndComp
$Comp
L CONN_01X05 P6
U 1 1 57F1C00C
P 3800 4325
F 0 "P6" H 3800 4625 50  0000 C CNN
F 1 "CONN_01X05" V 3900 4325 50  0001 C CNN
F 2 "Molex_NanoFit_1x05x2.50mm_Straight" H 3800 4325 50  0001 C CNN
F 3 "" H 3800 4325 50  0000 C CNN
	1    3800 4325
	0    -1   1    0   
$EndComp
$Comp
L CONN_01X05 P9
U 1 1 57F1C0D7
P 4300 4325
F 0 "P9" H 4300 4025 50  0000 C CNN
F 1 "CONN_01X05" V 4400 4325 50  0001 C CNN
F 2 "Molex_NanoFit_1x05x2.50mm_Straight" H 4300 4325 50  0001 C CNN
F 3 "" H 4300 4325 50  0000 C CNN
	1    4300 4325
	0    -1   1    0   
$EndComp
Wire Wire Line
	4100 4125 4100 4025
Wire Wire Line
	4000 4025 4000 4125
Wire Wire Line
	3900 4125 3900 4025
Wire Wire Line
	3800 4125 3800 4025
Wire Wire Line
	3700 4125 3700 4050
Wire Wire Line
	3700 4050 3600 4050
Wire Wire Line
	3600 4050 3600 4025
Wire Wire Line
	3600 4125 3600 4100
Wire Wire Line
	3600 4100 3500 4100
Wire Wire Line
	3500 4100 3500 4025
$Comp
L CONN_01X06 P4
U 1 1 57F1C476
P 3050 2825
F 0 "P4" H 3050 3175 50  0000 C CNN
F 1 "CONN_01X06" V 3150 2825 50  0001 C CNN
F 2 "Molex_NanoFit_1x06x2.50mm_Straight" H 3050 2825 50  0001 C CNN
F 3 "" H 3050 2825 50  0000 C CNN
	1    3050 2825
	0    -1   1    0   
$EndComp
$Comp
L CONN_01X08 P8
U 1 1 57F1C534
P 3850 2825
F 0 "P8" H 3850 3275 50  0000 C CNN
F 1 "CONN_01X08" V 3950 2825 50  0001 C CNN
F 2 "Molex_NanoFit_1x08x2.50mm_Straight" H 3850 2825 50  0001 C CNN
F 3 "" H 3850 2825 50  0000 C CNN
	1    3850 2825
	0    -1   1    0   
$EndComp
$Comp
L CONN_01X08 P13
U 1 1 57F1C6E2
P 5250 2825
F 0 "P13" H 5250 2350 50  0000 C CNN
F 1 "CONN_01X08" V 5350 2825 50  0001 C CNN
F 2 "Molex_NanoFit_1x08x2.50mm_Straight" H 5250 2825 50  0001 C CNN
F 3 "" H 5250 2825 50  0000 C CNN
	1    5250 2825
	0    -1   1    0   
$EndComp
$Comp
L CONN_01X05 P11
U 1 1 57F1C764
P 4600 2975
F 0 "P11" H 4600 3275 50  0000 C CNN
F 1 "CONN_01X05" V 4700 2975 50  0001 C CNN
F 2 "Molex_NanoFit_1x05x2.50mm_Straight" H 4600 2975 50  0001 C CNN
F 3 "" H 4600 2975 50  0000 C CNN
	1    4600 2975
	0    -1   1    0   
$EndComp
Wire Wire Line
	4800 2775 4800 2625
Wire Wire Line
	4700 2625 4700 2775
Wire Wire Line
	4600 2775 4600 2625
Wire Wire Line
	4500 2625 4500 2775
Wire Wire Line
	4400 2775 4400 2625
Wire Wire Line
	4400 2625 4300 2625
$Comp
L CONN_01X08 P7
U 1 1 57F1CB2B
P 3850 1800
F 0 "P7" H 3850 2250 50  0000 C CNN
F 1 "CONN_01X08" V 3950 1800 50  0001 C CNN
F 2 "Molex_NanoFit_1x08x2.50mm_Straight" H 3850 1800 50  0001 C CNN
F 3 "" H 3850 1800 50  0000 C CNN
	1    3850 1800
	0    -1   1    0   
$EndComp
$Comp
L CONN_01X05 P12
U 1 1 57F1CBAE
P 4700 1800
F 0 "P12" H 4700 2100 50  0000 C CNN
F 1 "CONN_01X05" V 4800 1800 50  0001 C CNN
F 2 "Molex_NanoFit_1x05x2.50mm_Straight" H 4700 1800 50  0001 C CNN
F 3 "" H 4700 1800 50  0000 C CNN
	1    4700 1800
	0    -1   1    0   
$EndComp
Wire Wire Line
	3500 1475 3500 1600
Wire Wire Line
	3600 1600 3600 1475
Wire Wire Line
	3700 1475 3700 1600
Wire Wire Line
	3800 1600 3800 1475
Wire Wire Line
	3900 1475 3900 1600
Wire Wire Line
	4000 1600 4000 1475
Wire Wire Line
	4000 1475 4100 1475
Wire Wire Line
	4100 1600 4100 1525
Wire Wire Line
	4100 1525 4200 1525
Wire Wire Line
	4200 1525 4200 1475
Wire Wire Line
	4200 1600 4200 1575
Wire Wire Line
	4200 1575 4300 1575
Wire Wire Line
	4300 1575 4300 1475
$Comp
L CONN_01X05 P15
U 1 1 57F1CE3C
P 5400 1800
F 0 "P15" H 5400 2100 50  0000 C CNN
F 1 "CONN_01X05" V 5500 1800 50  0001 C CNN
F 2 "Molex_NanoFit_1x05x2.50mm_Straight" H 5400 1800 50  0001 C CNN
F 3 "" H 5400 1800 50  0000 C CNN
	1    5400 1800
	0    -1   1    0   
$EndComp
Wire Wire Line
	5600 1475 5600 1600
Wire Wire Line
	5500 1600 5500 1475
Wire Wire Line
	5400 1475 5400 1600
Wire Wire Line
	5300 1600 5300 1475
Wire Wire Line
	5300 1475 5200 1475
Wire Wire Line
	5100 1475 5100 1525
Wire Wire Line
	5100 1525 5200 1525
Wire Wire Line
	5200 1525 5200 1600
$Comp
L CONN_01X05 P3
U 1 1 57F1D074
P 3000 1800
F 0 "P3" H 3000 2100 50  0000 C CNN
F 1 "CONN_01X05" V 3100 1800 50  0001 C CNN
F 2 "Molex_NanoFit_1x05x2.50mm_Straight" H 3000 1800 50  0001 C CNN
F 3 "" H 3000 1800 50  0000 C CNN
	1    3000 1800
	0    -1   1    0   
$EndComp
Wire Wire Line
	2800 1475 2800 1600
Wire Wire Line
	2900 1475 2900 1600
Wire Wire Line
	3000 1475 3000 1600
Wire Wire Line
	3100 1600 3100 1475
Wire Wire Line
	3100 1475 3200 1475
Wire Wire Line
	3200 1600 3200 1525
Wire Wire Line
	3200 1525 3300 1525
Wire Wire Line
	3300 1525 3300 1475
Wire Wire Line
	4900 1600 4900 1475
Wire Wire Line
	4800 1475 4800 1600
Wire Wire Line
	4700 1600 4700 1475
Wire Wire Line
	4600 1475 4600 1600
Wire Wire Line
	4500 1600 4500 1475
$Comp
L LOGO #G1
U 1 1 57F2DAE0
P 3625 10375
F 0 "#G1" H 3625 10272 60  0001 C CNN
F 1 "LOGO" H 3625 10478 60  0001 C CNN
F 2 "LOGO" H 3625 10375 60  0001 C CNN
F 3 "" H 3625 10375 60  0000 C CNN
	1    3625 10375
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 4025 4200 4025
Wire Wire Line
	4200 4050 4200 4125
Wire Wire Line
	4400 4125 4400 4100
Wire Wire Line
	4300 4125 4300 4075
Wire Wire Line
	4300 4025 4300 4050
Wire Wire Line
	4300 4050 4200 4050
Wire Wire Line
	4500 4025 4500 4075
Wire Wire Line
	4500 4075 4300 4075
Wire Wire Line
	4600 4025 4600 4100
Wire Wire Line
	4600 4100 4400 4100
Wire Wire Line
	4900 4025 4900 4125
Wire Wire Line
	4900 4125 4500 4125
Wire Wire Line
	5500 4025 5600 4025
Text Label 2800 1600 1    60   ~ 0
2C
Text Label 2900 1600 1    60   ~ 0
2F
Text Label 3000 1600 1    60   ~ 0
2I
Text Label 3100 1600 1    60   ~ 0
20
Text Label 3200 1600 1    60   ~ 0
2R
Text Label 3500 1600 1    60   ~ 0
3C
Text Label 3600 1600 1    60   ~ 0
3F
Text Label 3700 1600 1    60   ~ 0
3I
Text Label 3800 1600 1    60   ~ 0
3L
Text Label 3900 1600 1    60   ~ 0
3O
Text Label 4000 1600 1    60   ~ 0
3T
Text Label 4100 1600 1    60   ~ 0
3W
Text Label 4300 1575 1    60   ~ 0
3Z
Text Label 4500 1600 1    60   ~ 0
4C
Text Label 4600 1600 1    60   ~ 0
4F
Text Label 4700 1600 1    60   ~ 0
4I
Text Label 4800 1600 1    60   ~ 0
4K
Text Label 4900 1600 1    60   ~ 0
4N
Text Label 5100 1525 1    60   ~ 0
4T
Text Label 5300 1600 1    60   ~ 0
4W
Text Label 5400 1600 1    60   ~ 0
4AB
Text Label 5500 1600 1    60   ~ 0
4AE
Text Label 5600 1600 1    60   ~ 0
4AH
Text Label 2800 2625 1    60   ~ 0
2B
Text Label 2800 4025 1    60   ~ 0
2A
Text Label 2900 2625 1    60   ~ 0
2E
Text Label 3000 2625 1    60   ~ 0
2H
Text Label 3100 2625 1    60   ~ 0
2K
Text Label 3200 2625 1    60   ~ 0
2N
Text Label 3300 2625 1    60   ~ 0
2Q
Text Label 3500 2625 1    60   ~ 0
3B
Text Label 3600 2625 1    60   ~ 0
3E
Text Label 3700 2625 1    60   ~ 0
3H
Text Label 3800 2625 1    60   ~ 0
3K
Text Label 3900 2625 1    60   ~ 0
3N
Text Label 4000 2625 1    60   ~ 0
3Q
Text Label 4100 2625 1    60   ~ 0
3S
Text Label 4200 2625 1    60   ~ 0
3V
Text Label 4300 2625 1    60   ~ 0
3Y
Text Label 4500 2625 1    60   ~ 0
4B
Text Label 4600 2625 1    60   ~ 0
4E
Text Label 4700 2625 1    60   ~ 0
4H
Text Label 4800 2625 1    60   ~ 0
4J
Text Label 4900 2625 1    60   ~ 0
4M
Text Label 5000 2625 1    60   ~ 0
4P
Text Label 5100 2625 1    60   ~ 0
4S
Text Label 5200 2625 1    60   ~ 0
4V
Text Label 5300 2625 1    60   ~ 0
4X
Text Label 5400 2625 1    60   ~ 0
4AA
Text Label 5500 2625 1    60   ~ 0
4AD
Text Label 5600 2625 1    60   ~ 0
4AG
Text Label 2900 4025 1    60   ~ 0
2D
Text Label 3000 4025 1    60   ~ 0
2G
Text Label 3100 4025 1    60   ~ 0
2J
Text Label 3200 4025 1    60   ~ 0
2M
Text Label 3300 4025 1    60   ~ 0
2P
Text Label 3500 4025 1    60   ~ 0
3A
Text Label 3600 4025 1    60   ~ 0
3D
Text Label 3800 4025 1    60   ~ 0
3J
Text Label 3900 4025 1    60   ~ 0
3M
Text Label 4000 4025 1    60   ~ 0
3P
Text Label 4200 4025 1    60   ~ 0
3U
Text Label 4300 4025 1    60   ~ 0
3X
Text Label 4500 4025 1    60   ~ 0
4A
Text Label 4600 4025 1    60   ~ 0
4D
Text Label 4900 4025 1    60   ~ 0
4L
Text Label 5000 4025 1    60   ~ 0
4O
Text Label 5100 4025 1    60   ~ 0
4R
Text Label 5200 4025 1    60   ~ 0
4U
Text Label 5300 4025 1    60   ~ 0
4Z
Text Label 5400 4025 1    60   ~ 0
4AC
Text Label 5600 4025 1    60   ~ 0
4AF
$EndSCHEMATC
