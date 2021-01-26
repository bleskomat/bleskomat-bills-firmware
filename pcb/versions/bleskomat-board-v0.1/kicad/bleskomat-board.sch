EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Bleskomat board"
Date "2020-08-17"
Rev "0.0.1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 "Authors: Carlos Garcia Ortiz and Charles Hill"
$EndDescr
$Comp
L power:GND #PWR09
U 1 1 5F99284C
P 8200 4950
F 0 "#PWR09" H 8200 4700 50  0001 C CNN
F 1 "GND" H 8205 4777 50  0000 C CNN
F 2 "" H 8200 4950 50  0001 C CNN
F 3 "" H 8200 4950 50  0001 C CNN
	1    8200 4950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 5F99499C
P 3900 5300
F 0 "#PWR07" H 3900 5050 50  0001 C CNN
F 1 "GND" H 3905 5127 50  0000 C CNN
F 2 "" H 3900 5300 50  0001 C CNN
F 3 "" H 3900 5300 50  0001 C CNN
	1    3900 5300
	1    0    0    -1  
$EndComp
$Comp
L bleskomat-components:esp32 U1
U 1 1 5F9C4134
P 5300 3800
F 0 "U1" H 5325 4615 50  0000 C CNN
F 1 "esp32" H 5325 4524 50  0000 C CNN
F 2 "bleskomat-board:ESP32_Devkit_DOIT_V2" H 5300 3800 50  0001 C CNN
F 3 "" H 5300 3800 50  0001 C CNN
	1    5300 3800
	1    0    0    -1  
$EndComp
$Comp
L bleskomat-components:tft-connector U3
U 1 1 5F96F1AF
P 7450 4800
F 0 "U3" H 7100 5000 50  0000 L CNN
F 1 "tft-connector" H 7150 5400 50  0000 L CNN
F 2 "bleskomat-board:tft-connector" H 7450 5450 50  0001 C CNN
F 3 "" H 7450 5450 50  0001 C CNN
	1    7450 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7350 4950 8200 4950
Wire Wire Line
	7350 4350 6000 4350
Wire Wire Line
	7350 4450 6700 4450
Wire Wire Line
	6700 4450 6700 4650
Wire Wire Line
	6700 4650 6000 4650
Wire Wire Line
	7350 4550 6350 4550
Wire Wire Line
	6350 4550 6350 4500
Wire Wire Line
	6350 4500 6000 4500
Wire Wire Line
	7350 4650 6950 4650
Wire Wire Line
	6950 4650 6950 3300
Wire Wire Line
	6950 3300 6000 3300
Wire Wire Line
	7350 4750 6850 4750
Wire Wire Line
	6850 4750 6850 4200
Wire Wire Line
	6850 4200 6000 4200
Wire Wire Line
	7350 4850 6850 4850
Wire Wire Line
	6850 4850 6850 5400
Wire Wire Line
	7350 5050 6950 5050
Wire Wire Line
	6950 5700 4650 5700
Wire Wire Line
	4650 5700 4650 5400
Wire Wire Line
	6950 5050 6950 5700
Wire Wire Line
	4650 5250 3900 5250
Wire Wire Line
	3900 5250 3900 5300
$Comp
L bleskomat-components:button-connector U2
U 1 1 5F9DEBCB
P 7300 2550
F 0 "U2" H 8150 2800 50  0000 L CNN
F 1 "button-connector" H 7900 2650 50  0000 L CNN
F 2 "bleskomat-board:button-connector" H 7300 2350 50  0001 C CNN
F 3 "" H 7300 2350 50  0001 C CNN
	1    7300 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5F9EA67F
P 7800 3100
F 0 "R1" H 7870 3146 50  0000 L CNN
F 1 "10k" H 7870 3055 50  0000 L CNN
F 2 "bleskomat-board:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 7730 3100 50  0001 C CNN
F 3 "~" H 7800 3100 50  0001 C CNN
	1    7800 3100
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR010
U 1 1 5FA350AF
P 8350 3100
F 0 "#PWR010" H 8350 2850 50  0001 C CNN
F 1 "GND" H 8355 2927 50  0000 C CNN
F 2 "" H 8350 3100 50  0001 C CNN
F 3 "" H 8350 3100 50  0001 C CNN
	1    8350 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7950 3100 8350 3100
Wire Wire Line
	7200 4050 6000 4050
Wire Wire Line
	7650 3100 7200 3100
Wire Wire Line
	7200 3100 7200 4050
$Comp
L bleskomat-components:coinacceptor-connector coina-acceptor1
U 1 1 5FA47582
P 5300 2300
F 0 "coina-acceptor1" H 5000 2600 50  0000 L CNN
F 1 "coinacceptor-connector" H 4900 2050 50  0000 L CNN
F 2 "bleskomat-board:coinacceptor-connector" H 5000 2200 50  0001 C CNN
F 3 "" H 5000 2200 50  0001 C CNN
	1    5300 2300
	-1   0    0    1   
$EndComp
Wire Wire Line
	5700 2350 6450 2350
Wire Wire Line
	6450 4800 6000 4800
$Comp
L bleskomat-components:12V-SOCKET POWER1
U 1 1 5FA57484
P 2000 2150
F 0 "POWER1" H 2578 2321 50  0000 L CNN
F 1 "12V-SOCKET" H 2578 2230 50  0000 L CNN
F 2 "bleskomat-board:BarrelJack_Wuerth_6941xx301002" H 2000 2150 50  0001 C CNN
F 3 "" H 2000 2150 50  0001 C CNN
	1    2000 2150
	-1   0    0    1   
$EndComp
Wire Wire Line
	3800 3000 3800 2650
Wire Wire Line
	3800 2650 5850 2650
Wire Wire Line
	5850 2650 5850 2450
Wire Wire Line
	5850 2450 5700 2450
$Comp
L bleskomat-components:stepdown-connector stepdown1
U 1 1 5FA61144
P 2800 4950
F 0 "stepdown1" H 2800 5415 50  0000 C CNN
F 1 "stepdown-connector" H 2800 5324 50  0000 C CNN
F 2 "bleskomat-board:stepdown" H 2650 4950 50  0001 C CNN
F 3 "" H 2650 4950 50  0001 C CNN
	1    2800 4950
	1    0    0    -1  
$EndComp
$Comp
L bleskomat-board-rescue:billacceptor-connector-bleskomat-components bill-acceptor1
U 1 1 5FA76402
P 3400 3800
F 0 "bill-acceptor1" H 3375 4375 50  0000 C CNN
F 1 "billacceptor-connector" H 3375 4284 50  0000 C CNN
F 2 "bleskomat-board:billacceptor-connector" H 3300 3800 50  0001 C CNN
F 3 "" H 3300 3800 50  0001 C CNN
	1    3400 3800
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR03
U 1 1 5FABF99F
P 3100 1600
F 0 "#PWR03" H 3100 1350 50  0001 C CNN
F 1 "GND" H 3105 1427 50  0000 C CNN
F 2 "" H 3100 1600 50  0001 C CNN
F 3 "" H 3100 1600 50  0001 C CNN
	1    3100 1600
	-1   0    0    1   
$EndComp
Wire Wire Line
	4050 2400 4700 2400
Wire Wire Line
	4700 2400 4700 2900
Wire Wire Line
	4700 2900 6200 2900
Wire Wire Line
	6200 2900 6200 4950
Wire Wire Line
	6200 4950 6000 4950
Wire Wire Line
	7050 3700 8550 3700
Wire Wire Line
	8550 3700 8550 5700
Wire Wire Line
	8550 5700 6950 5700
Connection ~ 6950 5700
Wire Wire Line
	3700 3450 3700 3000
Connection ~ 3700 3000
Wire Wire Line
	3700 3000 3800 3000
$Comp
L power:GND #PWR02
U 1 1 5FAE0F7D
P 2450 3400
F 0 "#PWR02" H 2450 3150 50  0001 C CNN
F 1 "GND" H 2455 3227 50  0000 C CNN
F 2 "" H 2450 3400 50  0001 C CNN
F 3 "" H 2450 3400 50  0001 C CNN
	1    2450 3400
	-1   0    0    1   
$EndComp
Wire Wire Line
	3150 3450 2450 3450
Wire Wire Line
	2450 3450 2450 3400
Wire Wire Line
	3700 4150 4150 4150
Wire Wire Line
	4150 4150 4150 3050
Wire Wire Line
	4150 3050 6100 3050
Wire Wire Line
	6100 3050 6100 3750
Wire Wire Line
	6100 3750 6000 3750
Wire Wire Line
	6450 2350 6450 4800
$Comp
L power:GND #PWR01
U 1 1 5FAEB5C7
P 1950 4500
F 0 "#PWR01" H 1950 4250 50  0001 C CNN
F 1 "GND" H 1955 4327 50  0000 C CNN
F 2 "" H 1950 4500 50  0001 C CNN
F 3 "" H 1950 4500 50  0001 C CNN
	1    1950 4500
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5FAEB90F
P 3500 4650
F 0 "#PWR05" H 3500 4400 50  0001 C CNN
F 1 "GND" H 3505 4477 50  0000 C CNN
F 2 "" H 3500 4650 50  0001 C CNN
F 3 "" H 3500 4650 50  0001 C CNN
	1    3500 4650
	-1   0    0    1   
$EndComp
Wire Wire Line
	3300 4750 3500 4750
Wire Wire Line
	3500 4750 3500 4650
Wire Wire Line
	2300 4750 1950 4750
Wire Wire Line
	1950 4750 1950 4500
Wire Wire Line
	2300 5050 1800 5050
Wire Wire Line
	1800 5050 1800 3150
Wire Wire Line
	6000 5400 6150 5400
Wire Wire Line
	4350 5050 3700 5050
Wire Wire Line
	3700 5050 3700 5550
Wire Wire Line
	3700 6050 6150 6050
Wire Wire Line
	6150 6050 6150 5400
Connection ~ 3700 5050
Wire Wire Line
	3700 5050 3300 5050
Connection ~ 6150 5400
Wire Wire Line
	6150 5400 6850 5400
$Comp
L bleskomat-components:relay-connector relay1
U 1 1 5FA237E3
P 3800 2000
F 0 "relay1" H 3800 2515 50  0000 C CNN
F 1 "relay-connector" H 3800 2424 50  0000 C CNN
F 2 "bleskomat-board:relay-temporary-connector" H 3800 2000 50  0001 C CNN
F 3 "" H 3800 2000 50  0001 C CNN
	1    3800 2000
	0    1    1    0   
$EndComp
Wire Wire Line
	3950 1600 3950 1200
Wire Wire Line
	3950 1200 5900 1200
Wire Wire Line
	3250 3000 3700 3000
Wire Wire Line
	1800 3150 2050 3150
Wire Wire Line
	2050 3150 2050 2350
Wire Wire Line
	3250 3000 3250 2350
Connection ~ 2050 2350
$Comp
L power:GND #PWR0101
U 1 1 5FA67453
P 3950 2400
F 0 "#PWR0101" H 3950 2150 50  0001 C CNN
F 1 "GND" H 3955 2227 50  0000 C CNN
F 2 "" H 3950 2400 50  0001 C CNN
F 3 "" H 3950 2400 50  0001 C CNN
	1    3950 2400
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3850 3200 4350 3200
Wire Wire Line
	4350 3200 4350 5050
Wire Wire Line
	3850 2400 3850 3200
$Comp
L bleskomat-components:Screw_Terminal_01x03 J1
U 1 1 5FA8C619
P 1450 1450
F 0 "J1" H 1456 1767 50  0000 C CNN
F 1 "Screw_Terminal_01x03" H 1456 1676 50  0000 C CNN
F 2 "bleskomat-board:TerminalBlock_5mm" H 1450 1450 50  0001 C CNN
F 3 "~" H 1450 1450 50  0001 C CNN
	1    1450 1450
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5FA8EF89
P 2050 1200
F 0 "#PWR0102" H 2050 950 50  0001 C CNN
F 1 "GND" H 2055 1027 50  0000 C CNN
F 2 "" H 2050 1200 50  0001 C CNN
F 3 "" H 2050 1200 50  0001 C CNN
	1    2050 1200
	-1   0    0    1   
$EndComp
Wire Wire Line
	1650 1350 2050 1350
Wire Wire Line
	2050 1350 2050 1200
Wire Wire Line
	2050 2350 2450 2350
Wire Wire Line
	1650 1450 2450 1450
Wire Wire Line
	2450 1450 2450 2350
Connection ~ 2450 2350
Wire Wire Line
	2450 2350 3250 2350
Wire Wire Line
	1650 1550 1650 1950
Wire Wire Line
	1650 1950 800  1950
Wire Wire Line
	800  1950 800  5550
Wire Wire Line
	800  5550 3700 5550
Connection ~ 3700 5550
Wire Wire Line
	3700 5550 3700 6050
$Comp
L power:GND #PWR0103
U 1 1 5FAA8FCB
P 2050 2200
F 0 "#PWR0103" H 2050 1950 50  0001 C CNN
F 1 "GND" H 2055 2027 50  0000 C CNN
F 2 "" H 2050 2200 50  0001 C CNN
F 3 "" H 2050 2200 50  0001 C CNN
	1    2050 2200
	-1   0    0    1   
$EndComp
Wire Wire Line
	3100 1600 3850 1600
Wire Wire Line
	5700 2250 5900 2250
Wire Wire Line
	5900 2250 5900 1200
Wire Wire Line
	7050 2300 7200 2300
Wire Wire Line
	7050 2300 7050 3700
Wire Wire Line
	7200 3100 7100 3100
Wire Wire Line
	7100 3100 7100 2400
Wire Wire Line
	7100 2400 7200 2400
Connection ~ 7200 3100
$EndSCHEMATC
