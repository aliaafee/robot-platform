EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Mechanical:MountingHole H1
U 1 1 618CB622
P 9550 950
F 0 "H1" H 9650 996 50  0000 L CNN
F 1 "MountingHole" H 9650 905 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5_DIN965_Pad" H 9550 950 50  0001 C CNN
F 3 "~" H 9550 950 50  0001 C CNN
	1    9550 950 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 618E4922
P 9550 1350
F 0 "H2" H 9650 1396 50  0000 L CNN
F 1 "MountingHole" H 9650 1305 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5_DIN965_Pad" H 9550 1350 50  0001 C CNN
F 3 "~" H 9550 1350 50  0001 C CNN
	1    9550 1350
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 618E5159
P 9550 1700
F 0 "H3" H 9650 1746 50  0000 L CNN
F 1 "MountingHole" H 9650 1655 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5_DIN965_Pad" H 9550 1700 50  0001 C CNN
F 3 "~" H 9550 1700 50  0001 C CNN
	1    9550 1700
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 618E5809
P 9550 2100
F 0 "H4" H 9650 2146 50  0000 L CNN
F 1 "MountingHole" H 9650 2055 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5_DIN965_Pad" H 9550 2100 50  0001 C CNN
F 3 "~" H 9550 2100 50  0001 C CNN
	1    9550 2100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR022
U 1 1 6180F0FA
P 4050 3400
F 0 "#PWR022" H 4050 3150 50  0001 C CNN
F 1 "GND" H 4055 3227 50  0000 C CNN
F 2 "" H 4050 3400 50  0001 C CNN
F 3 "" H 4050 3400 50  0001 C CNN
	1    4050 3400
	1    0    0    -1  
$EndComp
Text GLabel 3100 3250 2    50   Input ~ 0
XTAL1
Text GLabel 3100 3350 2    50   Input ~ 0
XTAL2
Wire Wire Line
	3800 2900 3900 2900
Wire Wire Line
	3800 2900 3800 2550
Wire Wire Line
	3800 2550 4400 2550
Text GLabel 4400 2550 2    50   Input ~ 0
XTAL1
Text GLabel 4400 2900 2    50   Input ~ 0
XTAL2
Text GLabel 1900 2650 0    50   Input ~ 0
AREF
Text GLabel 5250 2550 0    50   Input ~ 0
AREF
$Comp
L Device:C C6
U 1 1 61846844
P 5350 2900
F 0 "C6" H 5235 2854 50  0000 R CNN
F 1 "100nF" H 5235 2945 50  0000 R CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5388 2750 50  0001 C CNN
F 3 "~" H 5350 2900 50  0001 C CNN
F 4 "C307331" H 5350 2900 50  0001 C CNN "Part #"
	1    5350 2900
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR028
U 1 1 61846F57
P 5350 3250
F 0 "#PWR028" H 5350 3000 50  0001 C CNN
F 1 "GND" H 5355 3077 50  0000 C CNN
F 2 "" H 5350 3250 50  0001 C CNN
F 3 "" H 5350 3250 50  0001 C CNN
	1    5350 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 2550 5350 2550
Wire Wire Line
	5350 2550 5350 2750
Wire Wire Line
	5350 3050 5350 3250
Text GLabel 3100 3550 2    50   Input ~ 0
A0
Text GLabel 3100 3650 2    50   Input ~ 0
A1
Text GLabel 3100 3750 2    50   Input ~ 0
A2
Text GLabel 3100 3850 2    50   Input ~ 0
A3
Text GLabel 3100 3950 2    50   Input ~ 0
SDA
Text GLabel 3100 4050 2    50   Input ~ 0
SCL
Text GLabel 1900 2850 0    50   Input ~ 0
A6
Text GLabel 1900 2950 0    50   Input ~ 0
A7
$Comp
L power:GND #PWR010
U 1 1 6186B05D
P 2500 5350
F 0 "#PWR010" H 2500 5100 50  0001 C CNN
F 1 "GND" H 2505 5177 50  0000 C CNN
F 2 "" H 2500 5350 50  0001 C CNN
F 3 "" H 2500 5350 50  0001 C CNN
	1    2500 5350
	1    0    0    -1  
$EndComp
Text GLabel 3100 4150 2    50   Input ~ 0
RESET
Text GLabel 4600 4450 2    50   Input ~ 0
RESET
Text GLabel 3850 4450 0    50   Input ~ 0
DTR
$Comp
L power:GND #PWR025
U 1 1 6189D775
P 4400 4950
F 0 "#PWR025" H 4400 4700 50  0001 C CNN
F 1 "GND" H 4405 4777 50  0000 C CNN
F 2 "" H 4400 4950 50  0001 C CNN
F 3 "" H 4400 4950 50  0001 C CNN
	1    4400 4950
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW1
U 1 1 6188A446
P 4400 4700
F 0 "SW1" V 4354 4848 50  0000 L CNN
F 1 "Reset" V 4445 4848 50  0000 L CNN
F 2 "Button_Switch_SMD:SW_Push_1P1T_NO_Vertical_Wuerth_434133025816" H 4400 4900 50  0001 C CNN
F 3 "~" H 4400 4900 50  0001 C CNN
	1    4400 4700
	0    1    1    0   
$EndComp
$Comp
L Device:R R3
U 1 1 6187F64B
P 4400 4250
F 0 "R3" H 4470 4296 50  0000 L CNN
F 1 "10k" H 4470 4205 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4330 4250 50  0001 C CNN
F 3 "~" H 4400 4250 50  0001 C CNN
F 4 "C17724" H 4400 4250 50  0001 C CNN "Part #"
	1    4400 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 4450 4400 4500
Wire Wire Line
	4400 4400 4400 4450
Connection ~ 4400 4450
Wire Wire Line
	4400 4900 4400 4950
Wire Wire Line
	4300 4450 4400 4450
Wire Wire Line
	4000 4450 3850 4450
Wire Wire Line
	4400 4450 4600 4450
Wire Wire Line
	2500 2350 2500 2250
Wire Wire Line
	2500 2250 2550 2250
Wire Wire Line
	2600 2250 2600 2350
Wire Wire Line
	2550 2250 2550 2150
Connection ~ 2550 2250
Wire Wire Line
	2550 2250 2600 2250
$Comp
L power:+3.3V #PWR011
U 1 1 61981A00
P 7400 4250
F 0 "#PWR011" H 7400 4100 50  0001 C CNN
F 1 "+3.3V" H 7415 4423 50  0000 C CNN
F 2 "" H 7400 4250 50  0001 C CNN
F 3 "" H 7400 4250 50  0001 C CNN
	1    7400 4250
	1    0    0    -1  
$EndComp
Text GLabel 3100 2950 2    50   Input ~ 0
MOSI
Text GLabel 3100 3050 2    50   Input ~ 0
MISO
Text GLabel 3100 3150 2    50   Input ~ 0
SCK
Text GLabel 5350 4050 2    50   Input ~ 0
SCK
$Comp
L Device:R R4
U 1 1 619BF9AF
P 5250 4300
F 0 "R4" H 5320 4346 50  0000 L CNN
F 1 "330" H 5320 4255 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5180 4300 50  0001 C CNN
F 3 "~" H 5250 4300 50  0001 C CNN
F 4 "C25741" H 5250 4300 50  0001 C CNN "Part #"
	1    5250 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 4050 5250 4050
Wire Wire Line
	5250 4050 5250 4150
$Comp
L Device:LED D2
U 1 1 619C8C1A
P 5250 4600
F 0 "D2" V 5250 4400 50  0000 C CNN
F 1 "GREEN" V 5150 4400 50  0000 C CNN
F 2 "Diode_SMD:D_0402_1005Metric" H 5250 4600 50  0001 C CNN
F 3 "~" H 5250 4600 50  0001 C CNN
	1    5250 4600
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR027
U 1 1 619E07ED
P 5250 4900
F 0 "#PWR027" H 5250 4650 50  0001 C CNN
F 1 "GND" H 5255 4727 50  0000 C CNN
F 2 "" H 5250 4900 50  0001 C CNN
F 3 "" H 5250 4900 50  0001 C CNN
	1    5250 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 4900 5250 4750
Text GLabel 3100 4350 2    50   Input ~ 0
RXI
Text GLabel 3100 4450 2    50   Input ~ 0
TXO
Text GLabel 3100 4550 2    50   Input ~ 0
D2
Text GLabel 3100 4650 2    50   Input ~ 0
D3
Text GLabel 3100 4750 2    50   Input ~ 0
D4
Text GLabel 3100 4850 2    50   Input ~ 0
D5
Text GLabel 3100 4950 2    50   Input ~ 0
D6
Text GLabel 3100 5050 2    50   Input ~ 0
D7
Text GLabel 3100 2650 2    50   Input ~ 0
D8
Text GLabel 3100 2750 2    50   Input ~ 0
D9
Text GLabel 3100 2850 2    50   Input ~ 0
D10
$Comp
L Connector_Generic:Conn_01x06 J5
U 1 1 61A40746
P 2450 6800
F 0 "J5" H 2400 7150 50  0000 L CNN
F 1 "ATMega_FTDI" H 2100 6350 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Horizontal" H 2450 6800 50  0001 C CNN
F 3 "~" H 2450 6800 50  0001 C CNN
	1    2450 6800
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR013
U 1 1 61A49A16
P 2650 6600
F 0 "#PWR013" H 2650 6350 50  0001 C CNN
F 1 "GND" V 2650 6400 50  0000 C CNN
F 2 "" H 2650 6600 50  0001 C CNN
F 3 "" H 2650 6600 50  0001 C CNN
	1    2650 6600
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR014
U 1 1 61A5BFE5
P 2650 6700
F 0 "#PWR014" H 2650 6450 50  0001 C CNN
F 1 "GND" V 2650 6500 50  0000 C CNN
F 2 "" H 2650 6700 50  0001 C CNN
F 3 "" H 2650 6700 50  0001 C CNN
	1    2650 6700
	0    -1   -1   0   
$EndComp
Text GLabel 2650 6900 2    50   Input ~ 0
RXI
Text GLabel 2650 7000 2    50   Input ~ 0
TXO
Text GLabel 2650 7100 2    50   Input ~ 0
DTR
$Comp
L Device:R R1
U 1 1 61B53DC6
P 3850 6450
F 0 "R1" H 3700 6500 50  0000 L CNN
F 1 "10k" H 3650 6400 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3780 6450 50  0001 C CNN
F 3 "~" H 3850 6450 50  0001 C CNN
F 4 "C17902" H 3850 6450 50  0001 C CNN "Part #"
	1    3850 6450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 61B54899
P 4000 6450
F 0 "R2" H 4070 6496 50  0000 L CNN
F 1 "10k" H 4070 6405 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3930 6450 50  0001 C CNN
F 3 "~" H 4000 6450 50  0001 C CNN
F 4 "C17902" H 4000 6450 50  0001 C CNN "Part #"
	1    4000 6450
	1    0    0    -1  
$EndComp
Text GLabel 4100 7000 2    50   Input ~ 0
SDA
Text GLabel 4100 7100 2    50   Input ~ 0
SCL
$Comp
L Connector_Generic:Conn_01x04 J6
U 1 1 61B66F8C
P 3250 6900
F 0 "J6" H 3250 7100 50  0000 C CNN
F 1 "I2C" H 3250 6550 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 3250 6900 50  0001 C CNN
F 3 "~" H 3250 6900 50  0001 C CNN
	1    3250 6900
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4100 7100 3850 7100
Wire Wire Line
	3450 7000 4000 7000
Wire Wire Line
	4000 6600 4000 7000
Connection ~ 4000 7000
Wire Wire Line
	4000 7000 4100 7000
Wire Wire Line
	3850 6600 3850 7100
Connection ~ 3850 7100
Wire Wire Line
	3850 7100 3450 7100
$Comp
L power:GND #PWR017
U 1 1 61BD8CB4
P 3450 6800
F 0 "#PWR017" H 3450 6550 50  0001 C CNN
F 1 "GND" V 3450 6600 50  0000 C CNN
F 2 "" H 3450 6800 50  0001 C CNN
F 3 "" H 3450 6800 50  0001 C CNN
	1    3450 6800
	0    -1   -1   0   
$EndComp
$Comp
L Driver_Motor:TB6612FNG U3
U 1 1 61CADE83
P 7200 2300
F 0 "U3" H 7100 1200 50  0000 C CNN
F 1 "TB6612FNG" H 7150 1100 50  0000 C CNN
F 2 "Package_SO:SSOP-24_5.3x8.2mm_P0.65mm" H 8500 1400 50  0001 C CNN
F 3 "https://toshiba.semicon-storage.com/us/product/linear/motordriver/detail.TB6612FNG.html" H 7650 2900 50  0001 C CNN
F 4 "C141517" H 7200 2300 50  0001 C CNN "Part #"
	1    7200 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8300 950  8200 950 
Wire Wire Line
	6900 950  6900 1300
$Comp
L power:GND #PWR036
U 1 1 61CADE9F
P 6900 3600
F 0 "#PWR036" H 6900 3350 50  0001 C CNN
F 1 "GND" H 6905 3427 50  0000 C CNN
F 2 "" H 6900 3600 50  0001 C CNN
F 3 "" H 6900 3600 50  0001 C CNN
	1    6900 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 3300 7400 3300
$Comp
L Device:CP C8
U 1 1 61CADEC3
P 7800 1100
F 0 "C8" H 7850 1200 50  0000 L CNN
F 1 "10uf" H 7850 1000 50  0000 L CNN
F 2 "Capacitor_SMD:CP_Elec_4x5.3" H 7838 950 50  0001 C CNN
F 3 "~" H 7800 1100 50  0001 C CNN
F 4 "C134721" H 7800 1100 50  0001 C CNN "Part #"
	1    7800 1100
	1    0    0    -1  
$EndComp
Connection ~ 7800 950 
$Comp
L Device:C C11
U 1 1 61CADECB
P 8200 1100
F 0 "C11" H 8250 1200 50  0000 L CNN
F 1 "100nF" H 8250 1000 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 8238 950 50  0001 C CNN
F 3 "~" H 8200 1100 50  0001 C CNN
F 4 "C24497" H 8200 1100 50  0001 C CNN "Part #"
	1    8200 1100
	1    0    0    -1  
$EndComp
Connection ~ 8200 950 
Wire Wire Line
	8200 950  7800 950 
$Comp
L power:GND #PWR031
U 1 1 61CADED5
P 6400 1250
F 0 "#PWR031" H 6400 1000 50  0001 C CNN
F 1 "GND" H 6405 1077 50  0000 C CNN
F 2 "" H 6400 1250 50  0001 C CNN
F 3 "" H 6400 1250 50  0001 C CNN
	1    6400 1250
	1    0    0    -1  
$EndComp
Connection ~ 6400 950 
Wire Wire Line
	6050 950  6400 950 
$Comp
L Device:C C7
U 1 1 61CADEE8
P 6400 1100
F 0 "C7" H 6150 1150 50  0000 L CNN
F 1 "100nF" H 6150 1000 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 6438 950 50  0001 C CNN
F 3 "~" H 6400 1100 50  0001 C CNN
F 4 "C24497" H 6400 1100 50  0001 C CNN "Part #"
	1    6400 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6900 3300 6900 3600
Text GLabel 6600 2100 0    50   Input ~ 0
D5
Text GLabel 6600 2500 0    50   Input ~ 0
D6
Text GLabel 5150 5600 2    50   Input ~ 0
D2
Text GLabel 5150 6300 2    50   Input ~ 0
D3
Text GLabel 6600 1900 0    50   Input ~ 0
D4
Text GLabel 6600 2400 0    50   Input ~ 0
D7
Text GLabel 6600 2600 0    50   Input ~ 0
D8
Text GLabel 8200 1800 2    50   Input ~ 0
MOTORA1
Text GLabel 8200 2100 2    50   Input ~ 0
MOTORA2
Text GLabel 8200 2700 2    50   Input ~ 0
MOTORB2
Text GLabel 8200 2400 2    50   Input ~ 0
MOTORB1
$Comp
L Connector_Generic:Conn_01x03 J8
U 1 1 61E2D632
P 4950 5500
F 0 "J8" H 4900 5750 50  0000 C CNN
F 1 "WheelEncA" H 4850 5250 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B3B-XH-A_1x03_P2.50mm_Vertical" H 4950 5500 50  0001 C CNN
F 3 "~" H 4950 5500 50  0001 C CNN
	1    4950 5500
	-1   0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x03 J9
U 1 1 61E3951F
P 4950 6200
F 0 "J9" H 4900 6450 50  0000 C CNN
F 1 "WheelEncB" H 4850 5950 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B3B-XH-A_1x03_P2.50mm_Vertical" H 4950 6200 50  0001 C CNN
F 3 "~" H 4950 6200 50  0001 C CNN
	1    4950 6200
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR032
U 1 1 61E3AC06
P 5150 5400
F 0 "#PWR032" H 5150 5150 50  0001 C CNN
F 1 "GND" V 5150 5200 50  0000 C CNN
F 2 "" H 5150 5400 50  0001 C CNN
F 3 "" H 5150 5400 50  0001 C CNN
	1    5150 5400
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR034
U 1 1 61E3BC10
P 5150 6100
F 0 "#PWR034" H 5150 5850 50  0001 C CNN
F 1 "GND" V 5150 5900 50  0000 C CNN
F 2 "" H 5150 6100 50  0001 C CNN
F 3 "" H 5150 6100 50  0001 C CNN
	1    5150 6100
	0    -1   -1   0   
$EndComp
Text GLabel 6600 2700 0    50   Input ~ 0
D9
Text GLabel 6600 2200 0    50   Input ~ 0
D10
$Comp
L Connector_Generic:Conn_01x02 J10
U 1 1 61EECF66
P 5850 5500
F 0 "J10" H 5800 5650 50  0000 C CNN
F 1 "MotorA" H 5800 5250 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 5850 5500 50  0001 C CNN
F 3 "~" H 5850 5500 50  0001 C CNN
	1    5850 5500
	-1   0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J11
U 1 1 61EF6401
P 5850 6200
F 0 "J11" H 5800 6350 50  0000 C CNN
F 1 "MotorB" H 5800 5950 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 5850 6200 50  0001 C CNN
F 3 "~" H 5850 6200 50  0001 C CNN
	1    5850 6200
	-1   0    0    -1  
$EndComp
Text GLabel 6050 5600 2    50   Input ~ 0
MOTORA1
Text GLabel 6050 5500 2    50   Input ~ 0
MOTORA2
Text GLabel 6050 6200 2    50   Input ~ 0
MOTORB1
Text GLabel 6050 6300 2    50   Input ~ 0
MOTORB2
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 61FABE2B
P 1100 5200
F 0 "J1" H 1050 5350 50  0000 C CNN
F 1 "9Vin" H 1050 4950 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 1100 5200 50  0001 C CNN
F 3 "~" H 1100 5200 50  0001 C CNN
	1    1100 5200
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 61FB5BA8
P 1300 5200
F 0 "#PWR01" H 1300 4950 50  0001 C CNN
F 1 "GND" V 1300 5000 50  0000 C CNN
F 2 "" H 1300 5200 50  0001 C CNN
F 3 "" H 1300 5200 50  0001 C CNN
	1    1300 5200
	0    -1   -1   0   
$EndComp
$Comp
L power:+9V #PWR02
U 1 1 61FBB2EB
P 1300 5300
F 0 "#PWR02" H 1300 5150 50  0001 C CNN
F 1 "+9V" V 1300 5500 50  0000 C CNN
F 2 "" H 1300 5300 50  0001 C CNN
F 3 "" H 1300 5300 50  0001 C CNN
	1    1300 5300
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J4
U 1 1 62119BFC
P 1550 6950
F 0 "J4" H 1600 7150 50  0000 C CNN
F 1 "ATMega_ICSP" H 1600 6700 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x03_P2.54mm_Vertical" H 1550 6950 50  0001 C CNN
F 3 "~" H 1550 6950 50  0001 C CNN
	1    1550 6950
	1    0    0    -1  
$EndComp
Text GLabel 1350 7050 0    50   Input ~ 0
RESET
Text GLabel 1350 6950 0    50   Input ~ 0
SCK
Text GLabel 1350 6850 0    50   Input ~ 0
MISO
Text GLabel 1850 6950 2    50   Input ~ 0
MOSI
$Comp
L power:GND #PWR08
U 1 1 62153891
P 1850 7050
F 0 "#PWR08" H 1850 6800 50  0001 C CNN
F 1 "GND" V 1850 6850 50  0000 C CNN
F 2 "" H 1850 7050 50  0001 C CNN
F 3 "" H 1850 7050 50  0001 C CNN
	1    1850 7050
	0    -1   -1   0   
$EndComp
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J7
U 1 1 622302DA
P 5950 7000
F 0 "J7" H 6000 7200 50  0000 C CNN
F 1 "ATMega AnalogPins" H 6000 6750 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x03_P2.54mm_Horizontal" H 5950 7000 50  0001 C CNN
F 3 "~" H 5950 7000 50  0001 C CNN
	1    5950 7000
	1    0    0    -1  
$EndComp
Text GLabel 5750 6900 0    50   Input ~ 0
A0
Text GLabel 6250 6900 2    50   Input ~ 0
A1
Text GLabel 5750 7000 0    50   Input ~ 0
A2
Text GLabel 6250 7000 2    50   Input ~ 0
A3
Text GLabel 5750 7100 0    50   Input ~ 0
A6
Text GLabel 6250 7100 2    50   Input ~ 0
A7
$Comp
L power:GND #PWR038
U 1 1 622ACF1B
P 7800 1250
F 0 "#PWR038" H 7800 1000 50  0001 C CNN
F 1 "GND" H 7805 1077 50  0000 C CNN
F 2 "" H 7800 1250 50  0001 C CNN
F 3 "" H 7800 1250 50  0001 C CNN
	1    7800 1250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR039
U 1 1 622AE6E1
P 8200 1250
F 0 "#PWR039" H 8200 1000 50  0001 C CNN
F 1 "GND" H 8205 1077 50  0000 C CNN
F 2 "" H 8200 1250 50  0001 C CNN
F 3 "" H 8200 1250 50  0001 C CNN
	1    8200 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7300 950  7400 950 
Wire Wire Line
	7500 950  7500 1300
Connection ~ 7500 950 
Wire Wire Line
	7500 950  7800 950 
Wire Wire Line
	7400 950  7400 1300
Connection ~ 7400 950 
Wire Wire Line
	7400 950  7500 950 
Wire Wire Line
	7300 950  7300 1300
Wire Wire Line
	9800 3450 9850 3450
$Comp
L power:+5V #PWR041
U 1 1 61868657
P 9850 3250
F 0 "#PWR041" H 9850 3100 50  0001 C CNN
F 1 "+5V" H 9865 3423 50  0000 C CNN
F 2 "" H 9850 3250 50  0001 C CNN
F 3 "" H 9850 3250 50  0001 C CNN
	1    9850 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9850 3250 9850 3450
Connection ~ 9850 3450
Wire Wire Line
	9850 3450 9900 3450
Wire Wire Line
	10100 3450 10150 3450
$Comp
L power:+3.3V #PWR043
U 1 1 61870306
P 10150 3250
F 0 "#PWR043" H 10150 3100 50  0001 C CNN
F 1 "+3.3V" H 10165 3423 50  0000 C CNN
F 2 "" H 10150 3250 50  0001 C CNN
F 3 "" H 10150 3250 50  0001 C CNN
	1    10150 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	10150 3250 10150 3450
Connection ~ 10150 3450
Wire Wire Line
	10150 3450 10200 3450
$Comp
L power:GND #PWR042
U 1 1 6187A0F9
P 9950 6200
F 0 "#PWR042" H 9950 5950 50  0001 C CNN
F 1 "GND" H 9955 6027 50  0000 C CNN
F 2 "" H 9950 6200 50  0001 C CNN
F 3 "" H 9950 6200 50  0001 C CNN
	1    9950 6200
	1    0    0    -1  
$EndComp
Wire Wire Line
	9950 6050 9950 6200
Connection ~ 9950 6050
Text GLabel 10800 4150 2    50   Input ~ 0
3v3_SDA
Text GLabel 10800 4250 2    50   Input ~ 0
3v3_SCL
$Comp
L Regulator_Switching:LM2596S-5 U2
U 1 1 617ECBF6
P 3550 1300
F 0 "U2" H 3550 1667 50  0000 C CNN
F 1 "LM2596S-5" H 3550 1576 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:TO-263-5_TabPin3" H 3600 1050 50  0001 L CIN
F 3 "http://www.ti.com/lit/ds/symlink/lm2596.pdf" H 3550 1300 50  0001 C CNN
F 4 "C194349" H 3550 1300 50  0001 C CNN "Part #"
	1    3550 1300
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C1
U 1 1 617F2816
P 2650 1350
F 0 "C1" H 2350 1400 50  0000 L CNN
F 1 "100uF" H 2300 1300 50  0000 L CNN
F 2 "Capacitor_SMD:CP_Elec_6.3x7.7" H 2688 1200 50  0001 C CNN
F 3 "~" H 2650 1350 50  0001 C CNN
F 4 "C127971" H 2650 1350 50  0001 C CNN "Part #"
	1    2650 1350
	1    0    0    -1  
$EndComp
$Comp
L Diode:1N5822 D1
U 1 1 617F7720
P 4250 1550
F 0 "D1" V 4300 1650 50  0000 L CNN
F 1 "SS34" V 4400 1650 50  0000 L CNN
F 2 "RobotHat:SS34" H 4250 1375 50  0001 C CNN
F 3 "http://www.vishay.com/docs/88526/1n5820.pdf" H 4250 1550 50  0001 C CNN
F 4 "C8678" V 4250 1550 50  0001 C CNN "Part #"
	1    4250 1550
	0    1    1    0   
$EndComp
$Comp
L Device:L L1
U 1 1 617FB4B7
P 4600 1400
F 0 "L1" V 4500 1400 50  0000 C CNN
F 1 "33uH" V 4700 1400 50  0000 C CNN
F 2 "RobotHat:YPRH1207-330M" H 4600 1400 50  0001 C CNN
F 3 "~" H 4600 1400 50  0001 C CNN
F 4 "C339951" V 4600 1400 50  0001 C CNN "Part #"
	1    4600 1400
	0    1    1    0   
$EndComp
$Comp
L Device:CP C5
U 1 1 617FDF61
P 5000 1550
F 0 "C5" H 5118 1596 50  0000 L CNN
F 1 "220uf" H 5118 1505 50  0000 L CNN
F 2 "Capacitor_SMD:CP_Elec_6.3x7.7" H 5038 1400 50  0001 C CNN
F 3 "~" H 5000 1550 50  0001 C CNN
F 4 "C371974" H 5000 1550 50  0001 C CNN "Part #"
	1    5000 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 1400 4250 1400
Wire Wire Line
	4250 1400 4450 1400
Connection ~ 4250 1400
Wire Wire Line
	4750 1400 5000 1400
Wire Wire Line
	5000 1400 5400 1400
Wire Wire Line
	5400 1400 5400 1250
Connection ~ 5000 1400
$Comp
L power:+5V #PWR029
U 1 1 61810B8B
P 5400 1250
F 0 "#PWR029" H 5400 1100 50  0001 C CNN
F 1 "+5V" H 5415 1423 50  0000 C CNN
F 2 "" H 5400 1250 50  0001 C CNN
F 3 "" H 5400 1250 50  0001 C CNN
	1    5400 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 1400 5000 1200
Wire Wire Line
	5000 1200 4050 1200
Connection ~ 2650 1200
$Comp
L power:GND #PWR019
U 1 1 6181C2EE
P 3550 1600
F 0 "#PWR019" H 3550 1350 50  0001 C CNN
F 1 "GND" H 3555 1427 50  0000 C CNN
F 2 "" H 3550 1600 50  0001 C CNN
F 3 "" H 3550 1600 50  0001 C CNN
	1    3550 1600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR026
U 1 1 6181C675
P 5000 1700
F 0 "#PWR026" H 5000 1450 50  0001 C CNN
F 1 "GND" H 5005 1527 50  0000 C CNN
F 2 "" H 5000 1700 50  0001 C CNN
F 3 "" H 5000 1700 50  0001 C CNN
	1    5000 1700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR023
U 1 1 6181CD38
P 4250 1700
F 0 "#PWR023" H 4250 1450 50  0001 C CNN
F 1 "GND" H 4255 1527 50  0000 C CNN
F 2 "" H 4250 1700 50  0001 C CNN
F 3 "" H 4250 1700 50  0001 C CNN
	1    4250 1700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR012
U 1 1 6181D33C
P 2650 1500
F 0 "#PWR012" H 2650 1250 50  0001 C CNN
F 1 "GND" H 2655 1327 50  0000 C CNN
F 2 "" H 2650 1500 50  0001 C CNN
F 3 "" H 2650 1500 50  0001 C CNN
	1    2650 1500
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR09
U 1 1 6181ECAE
P 850 1200
F 0 "#PWR09" H 850 1050 50  0001 C CNN
F 1 "+9V" H 865 1373 50  0000 C CNN
F 2 "" H 850 1200 50  0001 C CNN
F 3 "" H 850 1200 50  0001 C CNN
	1    850  1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 1200 2900 1200
$Comp
L power:GND #PWR016
U 1 1 61829011
P 3000 1600
F 0 "#PWR016" H 3000 1350 50  0001 C CNN
F 1 "GND" H 3005 1427 50  0000 C CNN
F 2 "" H 3000 1600 50  0001 C CNN
F 3 "" H 3000 1600 50  0001 C CNN
	1    3000 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 1400 3000 1400
Wire Wire Line
	3000 1400 3000 1600
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 6189A595
P 1100 5700
F 0 "J2" H 1050 5850 50  0000 C CNN
F 1 "5Vout" H 1050 5450 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 1100 5700 50  0001 C CNN
F 3 "~" H 1100 5700 50  0001 C CNN
	1    1100 5700
	-1   0    0    -1  
$EndComp
$Comp
L power:+5V #PWR04
U 1 1 6189FE27
P 1300 5800
F 0 "#PWR04" H 1300 5650 50  0001 C CNN
F 1 "+5V" V 1300 6000 50  0000 C CNN
F 2 "" H 1300 5800 50  0001 C CNN
F 3 "" H 1300 5800 50  0001 C CNN
	1    1300 5800
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR03
U 1 1 618A50B5
P 1300 5700
F 0 "#PWR03" H 1300 5450 50  0001 C CNN
F 1 "GND" V 1300 5500 50  0000 C CNN
F 2 "" H 1300 5700 50  0001 C CNN
F 3 "" H 1300 5700 50  0001 C CNN
	1    1300 5700
	0    -1   -1   0   
$EndComp
$Comp
L Mechanical:MountingHole H5
U 1 1 619FCF05
P 10500 1700
F 0 "H5" H 10600 1746 50  0000 L CNN
F 1 "MountingHole" H 10600 1655 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5_DIN965_Pad" H 10500 1700 50  0001 C CNN
F 3 "~" H 10500 1700 50  0001 C CNN
	1    10500 1700
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H6
U 1 1 619FD562
P 10500 2100
F 0 "H6" H 10600 2146 50  0000 L CNN
F 1 "MountingHole" H 10600 2055 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5_DIN965_Pad" H 10500 2100 50  0001 C CNN
F 3 "~" H 10500 2100 50  0001 C CNN
	1    10500 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7400 3600 7400 3300
Connection ~ 7400 3300
Wire Wire Line
	7400 3300 7300 3300
$Comp
L power:GND #PWR037
U 1 1 617FDBED
P 7400 3600
F 0 "#PWR037" H 7400 3350 50  0001 C CNN
F 1 "GND" H 7405 3427 50  0000 C CNN
F 2 "" H 7400 3600 50  0001 C CNN
F 3 "" H 7400 3600 50  0001 C CNN
	1    7400 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 2100 8000 2100
Wire Wire Line
	7800 2400 8000 2400
Wire Wire Line
	7800 2600 7900 2600
Wire Wire Line
	7900 2600 7900 2700
Wire Wire Line
	7900 2700 8000 2700
Wire Wire Line
	7800 1900 7850 1900
Wire Wire Line
	7850 1900 7850 1800
Wire Wire Line
	7850 1800 8000 1800
$Comp
L Device:C C9
U 1 1 618361DD
P 8000 1950
F 0 "C9" H 8050 2050 50  0000 L CNN
F 1 "100nF" H 8100 1950 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 8038 1800 50  0001 C CNN
F 3 "~" H 8000 1950 50  0001 C CNN
F 4 "C24497" H 8000 1950 50  0001 C CNN "Part #"
	1    8000 1950
	1    0    0    -1  
$EndComp
Connection ~ 8000 2100
Wire Wire Line
	8000 2100 8200 2100
Connection ~ 8000 1800
Wire Wire Line
	8000 1800 8200 1800
$Comp
L Device:C C10
U 1 1 6183D40F
P 8000 2550
F 0 "C10" H 8050 2650 50  0000 L CNN
F 1 "100nF" H 8100 2550 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 8038 2400 50  0001 C CNN
F 3 "~" H 8000 2550 50  0001 C CNN
F 4 "C24497" H 8000 2550 50  0001 C CNN "Field4"
	1    8000 2550
	1    0    0    -1  
$EndComp
Connection ~ 8000 2400
Wire Wire Line
	8000 2400 8200 2400
Connection ~ 8000 2700
Wire Wire Line
	8000 2700 8200 2700
Wire Wire Line
	6400 950  6900 950 
$Comp
L Device:R R5
U 1 1 618C86F1
P 5400 1550
F 0 "R5" H 5470 1596 50  0000 L CNN
F 1 "330" H 5470 1505 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5330 1550 50  0001 C CNN
F 3 "~" H 5400 1550 50  0001 C CNN
F 4 "C25741" H 5400 1550 50  0001 C CNN "Part #"
	1    5400 1550
	1    0    0    -1  
$EndComp
Connection ~ 5400 1400
$Comp
L Device:LED D3
U 1 1 618C9936
P 5400 1850
F 0 "D3" V 5400 1650 50  0000 C CNN
F 1 "RED" V 5300 1600 50  0000 C CNN
F 2 "Diode_SMD:D_0402_1005Metric" H 5400 1850 50  0001 C CNN
F 3 "~" H 5400 1850 50  0001 C CNN
F 4 "C130719" V 5400 1850 50  0001 C CNN "Part #"
	1    5400 1850
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 618CA7EF
P 5400 2000
F 0 "#PWR0101" H 5400 1750 50  0001 C CNN
F 1 "GND" H 5405 1827 50  0000 C CNN
F 2 "" H 5400 2000 50  0001 C CNN
F 3 "" H 5400 2000 50  0001 C CNN
	1    5400 2000
	1    0    0    -1  
$EndComp
NoConn ~ 10800 3850
NoConn ~ 10800 3950
NoConn ~ 10800 4450
NoConn ~ 10800 4550
NoConn ~ 10800 4650
NoConn ~ 10800 4850
NoConn ~ 10800 4950
NoConn ~ 10800 5050
NoConn ~ 10800 5150
NoConn ~ 10800 5250
Wire Wire Line
	9600 6050 9700 6050
Connection ~ 9700 6050
Wire Wire Line
	10200 6050 10300 6050
Connection ~ 10200 6050
Wire Wire Line
	10100 6050 10200 6050
Connection ~ 10100 6050
Wire Wire Line
	10000 6050 10100 6050
Wire Wire Line
	9950 6050 10000 6050
Connection ~ 10000 6050
Wire Wire Line
	9900 6050 9950 6050
Connection ~ 9900 6050
Wire Wire Line
	9800 6050 9900 6050
Wire Wire Line
	9700 6050 9800 6050
Connection ~ 9800 6050
$Comp
L Connector:Raspberry_Pi_2_3 J12
U 1 1 617E8A9F
P 10000 4750
F 0 "J12" H 10650 6150 50  0000 C CNN
F 1 "Raspberry_Pi_2_3" H 10650 6050 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x20_P2.54mm_Vertical" H 10000 4750 50  0001 C CNN
F 3 "https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_3bplus_1p0_reduced.pdf" H 10000 4750 50  0001 C CNN
	1    10000 4750
	1    0    0    -1  
$EndComp
NoConn ~ 10800 5450
NoConn ~ 10800 5550
NoConn ~ 9200 3850
NoConn ~ 9200 3950
NoConn ~ 9200 4150
NoConn ~ 9200 4250
NoConn ~ 9200 4350
NoConn ~ 9200 4550
NoConn ~ 9200 4650
NoConn ~ 9200 4750
NoConn ~ 9200 4950
NoConn ~ 9200 5050
NoConn ~ 9200 5150
NoConn ~ 9200 5250
NoConn ~ 9200 5350
NoConn ~ 9200 5450
$Comp
L Transistor_FET:AO3401A Q1
U 1 1 6182AC41
P 1350 1300
F 0 "Q1" V 1692 1300 50  0000 C CNN
F 1 "AO3401A" V 1601 1300 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 1550 1225 50  0001 L CIN
F 3 "http://www.aosmd.com/pdfs/datasheet/AO3401A.pdf" H 1350 1300 50  0001 L CNN
F 4 "C15127" V 1350 1300 50  0001 C CNN "JLCPCB Part #"
	1    1350 1300
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 61852289
P 1350 1500
F 0 "#PWR0102" H 1350 1250 50  0001 C CNN
F 1 "GND" H 1355 1327 50  0000 C CNN
F 2 "" H 1350 1500 50  0001 C CNN
F 3 "" H 1350 1500 50  0001 C CNN
	1    1350 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	850  1200 1150 1200
$Comp
L power:+9VA #PWR0103
U 1 1 6188F51A
P 2900 1200
F 0 "#PWR0103" H 2900 1075 50  0001 C CNN
F 1 "+9VA" H 2915 1373 50  0000 C CNN
F 2 "" H 2900 1200 50  0001 C CNN
F 3 "" H 2900 1200 50  0001 C CNN
	1    2900 1200
	1    0    0    -1  
$EndComp
Connection ~ 2900 1200
Wire Wire Line
	2900 1200 3050 1200
$Comp
L power:+9VA #PWR0104
U 1 1 618957ED
P 8200 950
F 0 "#PWR0104" H 8200 825 50  0001 C CNN
F 1 "+9VA" H 8215 1123 50  0000 C CNN
F 2 "" H 8200 950 50  0001 C CNN
F 3 "" H 8200 950 50  0001 C CNN
	1    8200 950 
	1    0    0    -1  
$EndComp
$Comp
L MCU_Microchip_ATmega:ATmega328P-AU U1
U 1 1 61807DAD
P 2500 3850
F 0 "U1" H 2500 2261 50  0000 C CNN
F 1 "ATmega328P-AU" H 2500 2050 50  0000 C CNN
F 2 "Package_QFP:TQFP-32_7x7mm_P0.8mm" H 2500 3850 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 2500 3850 50  0001 C CNN
F 4 "C14877" H 2500 3850 50  0001 C CNN "Part #"
	1    2500 3850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 61822586
P 6150 3300
F 0 "R6" H 6220 3346 50  0000 L CNN
F 1 "330" H 6220 3255 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 6080 3300 50  0001 C CNN
F 3 "~" H 6150 3300 50  0001 C CNN
F 4 "C25741" H 6150 3300 50  0001 C CNN "Part #"
	1    6150 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D4
U 1 1 618235F7
P 6150 3600
F 0 "D4" V 6150 3400 50  0000 C CNN
F 1 "GREEN" V 6050 3400 50  0000 C CNN
F 2 "Diode_SMD:D_0402_1005Metric" H 6150 3600 50  0001 C CNN
F 3 "~" H 6150 3600 50  0001 C CNN
	1    6150 3600
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 61824735
P 6150 3750
F 0 "#PWR0105" H 6150 3500 50  0001 C CNN
F 1 "GND" H 6155 3577 50  0000 C CNN
F 2 "" H 6150 3750 50  0001 C CNN
F 3 "" H 6150 3750 50  0001 C CNN
	1    6150 3750
	1    0    0    -1  
$EndComp
Text GLabel 6000 3000 0    50   Input ~ 0
D4
Wire Wire Line
	6000 3000 6150 3000
Wire Wire Line
	6150 3000 6150 3150
Text GLabel 8150 4700 2    50   Input ~ 0
SDA
Text GLabel 7150 4700 0    50   Input ~ 0
3v3_SDA
$Comp
L power:+5V #PWR040
U 1 1 618E2D51
P 7800 4250
F 0 "#PWR040" H 7800 4100 50  0001 C CNN
F 1 "+5V" H 7815 4423 50  0000 C CNN
F 2 "" H 7800 4250 50  0001 C CNN
F 3 "" H 7800 4250 50  0001 C CNN
	1    7800 4250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 618E7DE9
P 7400 4450
F 0 "R9" H 7200 4500 50  0000 L CNN
F 1 "10k" H 7200 4400 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7330 4450 50  0001 C CNN
F 3 "~" H 7400 4450 50  0001 C CNN
F 4 "C17724" H 7400 4450 50  0001 C CNN "Part #"
	1    7400 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 618EF6E6
P 7800 4450
F 0 "R7" H 7900 4500 50  0000 L CNN
F 1 "10k" H 7900 4400 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7730 4450 50  0001 C CNN
F 3 "~" H 7800 4450 50  0001 C CNN
	1    7800 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 6195FCAA
P 7800 5500
F 0 "R8" H 7850 5550 50  0000 L CNN
F 1 "10k" H 7850 5450 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7730 5500 50  0001 C CNN
F 3 "~" H 7800 5500 50  0001 C CNN
F 4 "C17724" H 7800 5500 50  0001 C CNN "Part #"
	1    7800 5500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 6196077A
P 7400 5500
F 0 "R10" H 7200 5550 50  0000 L CNN
F 1 "10k" H 7200 5450 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 7330 5500 50  0001 C CNN
F 3 "~" H 7400 5500 50  0001 C CNN
F 4 "C17724" H 7400 5500 50  0001 C CNN "Part #"
	1    7400 5500
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR044
U 1 1 6196B419
P 7800 5250
F 0 "#PWR044" H 7800 5100 50  0001 C CNN
F 1 "+5V" H 7815 5423 50  0000 C CNN
F 2 "" H 7800 5250 50  0001 C CNN
F 3 "" H 7800 5250 50  0001 C CNN
	1    7800 5250
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR045
U 1 1 6196BBEA
P 7400 5250
F 0 "#PWR045" H 7400 5100 50  0001 C CNN
F 1 "+3.3V" H 7415 5423 50  0000 C CNN
F 2 "" H 7400 5250 50  0001 C CNN
F 3 "" H 7400 5250 50  0001 C CNN
	1    7400 5250
	1    0    0    -1  
$EndComp
Text GLabel 8150 5800 2    50   Input ~ 0
SCL
Text GLabel 7200 5800 0    50   Input ~ 0
3v3_SCL
Wire Wire Line
	7400 5350 7400 5250
Wire Wire Line
	7800 5650 7800 5800
Wire Wire Line
	7400 5650 7400 5800
Wire Wire Line
	7400 5800 7200 5800
$Comp
L power:+5V #PWR0106
U 1 1 619E1647
P 2550 2150
F 0 "#PWR0106" H 2550 2000 50  0001 C CNN
F 1 "+5V" H 2565 2323 50  0000 C CNN
F 2 "" H 2550 2150 50  0001 C CNN
F 3 "" H 2550 2150 50  0001 C CNN
	1    2550 2150
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0107
U 1 1 619E5D39
P 6050 950
F 0 "#PWR0107" H 6050 800 50  0001 C CNN
F 1 "+5V" H 6065 1123 50  0000 C CNN
F 2 "" H 6050 950 50  0001 C CNN
F 3 "" H 6050 950 50  0001 C CNN
	1    6050 950 
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0109
U 1 1 61A0998E
P 1850 6850
F 0 "#PWR0109" H 1850 6700 50  0001 C CNN
F 1 "+5V" V 1850 7050 50  0000 C CNN
F 2 "" H 1850 6850 50  0001 C CNN
F 3 "" H 1850 6850 50  0001 C CNN
	1    1850 6850
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR0110
U 1 1 61A0A222
P 2650 6800
F 0 "#PWR0110" H 2650 6650 50  0001 C CNN
F 1 "+5V" V 2650 7000 50  0000 C CNN
F 2 "" H 2650 6800 50  0001 C CNN
F 3 "" H 2650 6800 50  0001 C CNN
	1    2650 6800
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR0111
U 1 1 61A0C8F1
P 3450 6900
F 0 "#PWR0111" H 3450 6750 50  0001 C CNN
F 1 "+5V" V 3450 7100 50  0000 C CNN
F 2 "" H 3450 6900 50  0001 C CNN
F 3 "" H 3450 6900 50  0001 C CNN
	1    3450 6900
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR0112
U 1 1 61A0D444
P 5150 6200
F 0 "#PWR0112" H 5150 6050 50  0001 C CNN
F 1 "+5V" V 5150 6400 50  0000 C CNN
F 2 "" H 5150 6200 50  0001 C CNN
F 3 "" H 5150 6200 50  0001 C CNN
	1    5150 6200
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR0113
U 1 1 61A0DD1C
P 5150 5500
F 0 "#PWR0113" H 5150 5350 50  0001 C CNN
F 1 "+5V" V 5150 5700 50  0000 C CNN
F 2 "" H 5150 5500 50  0001 C CNN
F 3 "" H 5150 5500 50  0001 C CNN
	1    5150 5500
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR0114
U 1 1 61A1ED4C
P 3850 6300
F 0 "#PWR0114" H 3850 6150 50  0001 C CNN
F 1 "+5V" H 3850 6500 50  0000 C CNN
F 2 "" H 3850 6300 50  0001 C CNN
F 3 "" H 3850 6300 50  0001 C CNN
	1    3850 6300
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0115
U 1 1 61A2C254
P 4000 6300
F 0 "#PWR0115" H 4000 6150 50  0001 C CNN
F 1 "+5V" H 4000 6500 50  0000 C CNN
F 2 "" H 4000 6300 50  0001 C CNN
F 3 "" H 4000 6300 50  0001 C CNN
	1    4000 6300
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0116
U 1 1 61A3A3F5
P 4400 4100
F 0 "#PWR0116" H 4400 3950 50  0001 C CNN
F 1 "+5V" H 4400 4300 50  0000 C CNN
F 2 "" H 4400 4100 50  0001 C CNN
F 3 "" H 4400 4100 50  0001 C CNN
	1    4400 4100
	1    0    0    -1  
$EndComp
$Comp
L Transistor_FET:2N7002 Q2
U 1 1 61818AAA
P 7600 4600
F 0 "Q2" V 7849 4600 50  0000 C CNN
F 1 "2N7002" V 7940 4600 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7800 4525 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/NDS7002A-D.PDF" H 7600 4600 50  0001 L CNN
F 4 "C8545" V 7600 4600 50  0001 C CNN "Part #"
	1    7600 4600
	0    1    1    0   
$EndComp
$Comp
L Transistor_FET:2N7002 Q3
U 1 1 618386BA
P 7600 5700
F 0 "Q3" V 7849 5700 50  0000 C CNN
F 1 "2N7002" V 7940 5700 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7800 5625 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/NDS7002A-D.PDF" H 7600 5700 50  0001 L CNN
F 4 "C8545" V 7600 5700 50  0001 C CNN "Part #"
	1    7600 5700
	0    1    1    0   
$EndComp
Connection ~ 7800 5800
Connection ~ 7400 5800
Wire Wire Line
	7800 5250 7800 5350
Wire Wire Line
	7400 4250 7400 4300
Wire Wire Line
	7400 4600 7400 4700
Wire Wire Line
	7400 4700 7150 4700
Connection ~ 7400 4700
Wire Wire Line
	7800 4700 8150 4700
Wire Wire Line
	7800 4700 7800 4600
Connection ~ 7800 4700
Wire Wire Line
	7800 4300 7800 4250
Wire Wire Line
	7800 5800 8150 5800
Wire Wire Line
	7600 4400 7600 4300
Wire Wire Line
	7600 4300 7400 4300
Connection ~ 7400 4300
Wire Wire Line
	7600 5500 7600 5350
Wire Wire Line
	7600 5350 7400 5350
Connection ~ 7400 5350
$Comp
L Device:Crystal_GND3 Y1
U 1 1 61934016
P 4050 2900
F 0 "Y1" H 4050 3168 50  0000 C CNN
F 1 "16Mhz" H 4050 3077 50  0000 C CNN
F 2 "RobotHat:CSTCE16M0V53-R0" H 4050 2900 50  0001 C CNN
F 3 "~" H 4050 2900 50  0001 C CNN
F 4 "C32180" H 4050 2900 50  0001 C CNN "Part #"
	1    4050 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 2900 4400 2900
Wire Wire Line
	4050 3100 4050 3400
Wire Wire Line
	1550 1200 2650 1200
$Comp
L Device:C C3
U 1 1 619362A8
P 4150 4450
F 0 "C3" V 4300 4500 50  0000 R CNN
F 1 "100nF" V 4000 4550 50  0000 R CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4188 4300 50  0001 C CNN
F 3 "~" H 4150 4450 50  0001 C CNN
F 4 "C307331" V 4150 4450 50  0001 C CNN "Part #"
	1    4150 4450
	0    -1   -1   0   
$EndComp
$EndSCHEMATC
