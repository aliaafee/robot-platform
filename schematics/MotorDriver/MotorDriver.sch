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
Text GLabel 3250 2850 2    50   Input ~ 0
SCL
Text GLabel 3250 2750 2    50   Input ~ 0
SDA
Wire Wire Line
	2850 2750 3250 2750
Wire Wire Line
	2850 2850 3250 2850
$Comp
L power:+3.3V #PWR04
U 1 1 61785767
P 2250 1000
F 0 "#PWR04" H 2250 850 50  0001 C CNN
F 1 "+3.3V" H 2265 1173 50  0000 C CNN
F 2 "" H 2250 1000 50  0001 C CNN
F 3 "" H 2250 1000 50  0001 C CNN
	1    2250 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2250 1000 2250 1150
$Comp
L power:GND #PWR05
U 1 1 6178701E
P 2250 4350
F 0 "#PWR05" H 2250 4100 50  0001 C CNN
F 1 "GND" H 2255 4177 50  0000 C CNN
F 2 "" H 2250 4350 50  0001 C CNN
F 3 "" H 2250 4350 50  0001 C CNN
	1    2250 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2250 4350 2250 4150
$Comp
L Connector:Conn_01x04_Male J5
U 1 1 617935FD
P 5150 1700
F 0 "J5" H 5258 1981 50  0000 C CNN
F 1 "I2C" H 5258 1890 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 5150 1700 50  0001 C CNN
F 3 "~" H 5150 1700 50  0001 C CNN
	1    5150 1700
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR017
U 1 1 61794384
P 5650 1700
F 0 "#PWR017" H 5650 1550 50  0001 C CNN
F 1 "+3.3V" V 5665 1828 50  0000 L CNN
F 2 "" H 5650 1700 50  0001 C CNN
F 3 "" H 5650 1700 50  0001 C CNN
	1    5650 1700
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR016
U 1 1 61795C16
P 5650 1600
F 0 "#PWR016" H 5650 1350 50  0001 C CNN
F 1 "GND" V 5655 1472 50  0000 R CNN
F 2 "" H 5650 1600 50  0001 C CNN
F 3 "" H 5650 1600 50  0001 C CNN
	1    5650 1600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5350 1600 5650 1600
Wire Wire Line
	5350 1700 5650 1700
Wire Wire Line
	5350 1800 5650 1800
Wire Wire Line
	5350 1900 5650 1900
Text Label 5650 1800 2    50   ~ 0
SDA
Text Label 5650 1900 2    50   ~ 0
SCL
$Comp
L Device:Crystal Y1
U 1 1 617AE457
P 3600 2100
F 0 "Y1" V 3554 2231 50  0000 L CNN
F 1 "16MHz" V 3645 2231 50  0000 L CNN
F 2 "Crystal:Crystal_HC49-4H_Vertical" H 3600 2100 50  0001 C CNN
F 3 "~" H 3600 2100 50  0001 C CNN
	1    3600 2100
	0    1    1    0   
$EndComp
$Comp
L Device:C C5
U 1 1 617B0546
P 3850 1800
F 0 "C5" H 3735 1754 50  0000 R CNN
F 1 "22pf" H 3735 1845 50  0000 R CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 3888 1650 50  0001 C CNN
F 3 "~" H 3850 1800 50  0001 C CNN
	1    3850 1800
	-1   0    0    1   
$EndComp
$Comp
L Device:C C6
U 1 1 617B2583
P 3850 2400
F 0 "C6" H 3965 2446 50  0000 L CNN
F 1 "22pf" H 3965 2355 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 3888 2250 50  0001 C CNN
F 3 "~" H 3850 2400 50  0001 C CNN
	1    3850 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 2250 3600 2250
Wire Wire Line
	3850 1950 3600 1950
Wire Wire Line
	3850 2550 4150 2550
Wire Wire Line
	5350 3450 5700 3450
Wire Wire Line
	5350 3550 5700 3550
Text Label 5700 3450 2    50   ~ 0
RX
Text Label 5700 3550 2    50   ~ 0
TX
$Comp
L power:+3.3V #PWR015
U 1 1 617D6371
P 5600 3250
F 0 "#PWR015" H 5600 3100 50  0001 C CNN
F 1 "+3.3V" V 5615 3378 50  0000 L CNN
F 2 "" H 5600 3250 50  0001 C CNN
F 3 "" H 5600 3250 50  0001 C CNN
	1    5600 3250
	0    1    1    0   
$EndComp
Wire Wire Line
	5350 3350 5700 3350
Text GLabel 3300 3150 2    50   Input ~ 0
RX
Text GLabel 3300 3250 2    50   Input ~ 0
TX
Wire Wire Line
	2850 3150 3300 3150
Wire Wire Line
	2850 3250 3300 3250
$Comp
L power:+3.3V #PWR019
U 1 1 617EF52C
P 7300 1700
F 0 "#PWR019" H 7300 1550 50  0001 C CNN
F 1 "+3.3V" V 7315 1828 50  0000 L CNN
F 2 "" H 7300 1700 50  0001 C CNN
F 3 "" H 7300 1700 50  0001 C CNN
	1    7300 1700
	0    1    1    0   
$EndComp
Wire Wire Line
	7100 1700 7300 1700
$Comp
L power:GND #PWR018
U 1 1 617F0216
P 7300 1600
F 0 "#PWR018" H 7300 1350 50  0001 C CNN
F 1 "GND" V 7305 1472 50  0000 R CNN
F 2 "" H 7300 1600 50  0001 C CNN
F 3 "" H 7300 1600 50  0001 C CNN
	1    7300 1600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7100 1600 7300 1600
$Comp
L power:GND #PWR014
U 1 1 617F264D
P 5600 3150
F 0 "#PWR014" H 5600 2900 50  0001 C CNN
F 1 "GND" V 5605 3022 50  0000 R CNN
F 2 "" H 5600 3150 50  0001 C CNN
F 3 "" H 5600 3150 50  0001 C CNN
	1    5600 3150
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R1
U 1 1 617FB5F9
P 3700 2950
F 0 "R1" V 3493 2950 50  0000 C CNN
F 1 "10k" V 3584 2950 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 3630 2950 50  0001 C CNN
F 3 "~" H 3700 2950 50  0001 C CNN
	1    3700 2950
	0    1    1    0   
$EndComp
Wire Wire Line
	3550 2950 3150 2950
$Comp
L power:+3.3V #PWR08
U 1 1 617FF0FA
P 4050 2950
F 0 "#PWR08" H 4050 2800 50  0001 C CNN
F 1 "+3.3V" V 4065 3078 50  0000 L CNN
F 2 "" H 4050 2950 50  0001 C CNN
F 3 "" H 4050 2950 50  0001 C CNN
	1    4050 2950
	0    1    1    0   
$EndComp
Wire Wire Line
	3850 2950 4050 2950
$Comp
L Driver_Motor:TB6612FNG U1
U 1 1 618164D4
P 2150 6250
F 0 "U1" H 2150 5161 50  0000 C CNN
F 1 "TB6612FNG" H 2150 5070 50  0000 C CNN
F 2 "Package_SO:SSOP-24_5.3x8.2mm_P0.65mm" H 3450 5350 50  0001 C CNN
F 3 "https://toshiba.semicon-storage.com/us/product/linear/motordriver/detail.TB6612FNG.html" H 2600 6850 50  0001 C CNN
	1    2150 6250
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J8
U 1 1 61819E97
P 7050 3200
F 0 "J8" H 7158 3381 50  0000 C CNN
F 1 "9VIN" H 7158 3290 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 7050 3200 50  0001 C CNN
F 3 "~" H 7050 3200 50  0001 C CNN
	1    7050 3200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR020
U 1 1 6181B5C3
P 7500 3200
F 0 "#PWR020" H 7500 2950 50  0001 C CNN
F 1 "GND" V 7505 3072 50  0000 R CNN
F 2 "" H 7500 3200 50  0001 C CNN
F 3 "" H 7500 3200 50  0001 C CNN
	1    7500 3200
	0    -1   -1   0   
$EndComp
$Comp
L power:+9V #PWR021
U 1 1 6181CF1C
P 7500 3300
F 0 "#PWR021" H 7500 3150 50  0001 C CNN
F 1 "+9V" V 7515 3428 50  0000 L CNN
F 2 "" H 7500 3300 50  0001 C CNN
F 3 "" H 7500 3300 50  0001 C CNN
	1    7500 3300
	0    1    1    0   
$EndComp
Wire Wire Line
	7250 3200 7500 3200
Wire Wire Line
	7250 3300 7500 3300
$Comp
L power:+9V #PWR07
U 1 1 61832A9E
P 3150 4750
F 0 "#PWR07" H 3150 4600 50  0001 C CNN
F 1 "+9V" H 3165 4923 50  0000 C CNN
F 2 "" H 3150 4750 50  0001 C CNN
F 3 "" H 3150 4750 50  0001 C CNN
	1    3150 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 4750 3150 4900
Wire Wire Line
	3150 4900 3050 4900
Wire Wire Line
	2450 4900 2450 5250
Wire Wire Line
	2450 4900 2350 4900
Wire Wire Line
	2350 4900 2350 5250
Connection ~ 2450 4900
Wire Wire Line
	2350 4900 2250 4900
Wire Wire Line
	2250 4900 2250 5250
Connection ~ 2350 4900
$Comp
L power:+3.3V #PWR01
U 1 1 61835A96
P 1000 4900
F 0 "#PWR01" H 1000 4750 50  0001 C CNN
F 1 "+3.3V" H 1015 5073 50  0000 C CNN
F 2 "" H 1000 4900 50  0001 C CNN
F 3 "" H 1000 4900 50  0001 C CNN
	1    1000 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 4900 1850 5250
$Comp
L power:GND #PWR03
U 1 1 6183A5B7
P 1850 7550
F 0 "#PWR03" H 1850 7300 50  0001 C CNN
F 1 "GND" H 1855 7377 50  0000 C CNN
F 2 "" H 1850 7550 50  0001 C CNN
F 3 "" H 1850 7550 50  0001 C CNN
	1    1850 7550
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J1
U 1 1 618579E3
P 3500 6000
F 0 "J1" H 3472 5882 50  0000 R CNN
F 1 "MOUTA" H 3472 5973 50  0000 R CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 3500 6000 50  0001 C CNN
F 3 "~" H 3500 6000 50  0001 C CNN
	1    3500 6000
	-1   0    0    1   
$EndComp
Wire Wire Line
	2750 5850 3300 5850
Wire Wire Line
	3300 5850 3300 5900
Wire Wire Line
	2750 6050 3300 6050
Wire Wire Line
	3300 6050 3300 6000
$Comp
L Connector:Conn_01x02_Male J2
U 1 1 618476A6
P 3500 6500
F 0 "J2" H 3472 6382 50  0000 R CNN
F 1 "MOUTB" H 3472 6473 50  0000 R CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 3500 6500 50  0001 C CNN
F 3 "~" H 3500 6500 50  0001 C CNN
	1    3500 6500
	-1   0    0    1   
$EndComp
Wire Wire Line
	2750 6550 3050 6550
Wire Wire Line
	3050 6550 3050 6400
Wire Wire Line
	3050 6400 3300 6400
Wire Wire Line
	3300 6500 2900 6500
Wire Wire Line
	2900 6500 2900 6350
Wire Wire Line
	2900 6350 2750 6350
Wire Wire Line
	2250 7250 1850 7250
Connection ~ 1850 7250
Wire Wire Line
	2450 7250 2250 7250
Connection ~ 2250 7250
Wire Wire Line
	1850 7250 1850 7500
$Comp
L MCU_Microchip_ATmega:ATmega328P-PU U2
U 1 1 6177F61E
P 2250 2650
F 0 "U2" H 1606 2696 50  0000 R CNN
F 1 "ATmega328P-PU" H 1606 2605 50  0000 R CNN
F 2 "Package_DIP:DIP-28_W7.62mm" H 2250 2650 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 2250 2650 50  0001 C CNN
	1    2250 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 7250 1850 7550
Wire Wire Line
	2850 3650 3250 3650
Wire Wire Line
	2850 3750 3250 3750
Text Label 3250 3650 2    50   ~ 0
PWMA
Text Label 3250 3750 2    50   ~ 0
PWMB
Wire Wire Line
	1550 6050 1250 6050
Wire Wire Line
	1550 6150 1250 6150
Text Label 1250 6050 2    50   ~ 0
PWMA
Text Label 1250 6150 2    50   ~ 0
PWMB
Wire Wire Line
	1550 5850 1250 5850
Text Label 1250 5850 2    50   ~ 0
STBY
Wire Wire Line
	2850 3550 3250 3550
Text Label 3250 3550 2    50   ~ 0
STBY
Wire Wire Line
	1550 6350 1250 6350
Wire Wire Line
	1550 6450 1250 6450
Text Label 1250 6350 2    50   ~ 0
AIN1
Text Label 1250 6450 2    50   ~ 0
AIN2
Wire Wire Line
	2850 3350 3250 3350
Text Label 3250 3350 2    50   ~ 0
INT0
Wire Wire Line
	2850 3450 3250 3450
Text Label 3250 3450 2    50   ~ 0
INT1
Wire Wire Line
	1550 6550 1250 6550
Wire Wire Line
	1550 6650 1250 6650
Text Label 1250 6550 2    50   ~ 0
BIN1
Text Label 1250 6650 2    50   ~ 0
BIN2
Text Label 3250 1850 2    50   ~ 0
AIN1
Text Label 3250 1950 2    50   ~ 0
AIN2
$Comp
L Connector:Conn_01x05_Male J6
U 1 1 617CEDCC
P 5150 3350
F 0 "J6" H 5250 3750 50  0000 C CNN
F 1 "UART" H 5250 3650 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x05_P2.54mm_Vertical" H 5150 3350 50  0001 C CNN
F 3 "~" H 5150 3350 50  0001 C CNN
	1    5150 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 3150 5600 3150
Wire Wire Line
	5350 3250 5600 3250
Text Label 5700 3350 2    50   ~ 0
RST
$Comp
L Device:C C7
U 1 1 618EE590
P 3900 3350
F 0 "C7" V 3648 3350 50  0000 C CNN
F 1 "10nf" V 3739 3350 50  0000 C CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 3938 3200 50  0001 C CNN
F 3 "~" H 3900 3350 50  0001 C CNN
	1    3900 3350
	0    1    1    0   
$EndComp
Wire Wire Line
	4050 3350 4200 3350
Wire Wire Line
	3750 3350 3750 3050
Wire Wire Line
	3750 3050 3150 3050
Wire Wire Line
	3150 3050 3150 2950
Connection ~ 3150 2950
Wire Wire Line
	3150 2950 2850 2950
Text GLabel 4200 3350 2    50   Input ~ 0
RST
$Comp
L Device:CP C2
U 1 1 61787A26
P 1550 5050
F 0 "C2" H 1668 5096 50  0000 L CNN
F 1 "10uf" H 1668 5005 50  0000 L CNN
F 2 "Capacitor_SMD:CP_Elec_3x5.3" H 1588 4900 50  0001 C CNN
F 3 "~" H 1550 5050 50  0001 C CNN
	1    1550 5050
	1    0    0    -1  
$EndComp
Connection ~ 1550 4900
Wire Wire Line
	1550 4900 1850 4900
$Comp
L Device:CP C3
U 1 1 617887D3
P 2700 5050
F 0 "C3" H 2818 5096 50  0000 L CNN
F 1 "10uf" H 2818 5005 50  0000 L CNN
F 2 "Capacitor_SMD:CP_Elec_3x5.3" H 2738 4900 50  0001 C CNN
F 3 "~" H 2700 5050 50  0001 C CNN
	1    2700 5050
	1    0    0    -1  
$EndComp
Connection ~ 2700 4900
Wire Wire Line
	2700 4900 2450 4900
$Comp
L Device:C C4
U 1 1 61788F8B
P 3050 5050
F 0 "C4" H 3165 5096 50  0000 L CNN
F 1 "0.1uf" H 3165 5005 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 3088 4900 50  0001 C CNN
F 3 "~" H 3050 5050 50  0001 C CNN
	1    3050 5050
	1    0    0    -1  
$EndComp
Connection ~ 3050 4900
Wire Wire Line
	3050 4900 2700 4900
Connection ~ 4150 2100
Wire Wire Line
	4150 2550 4150 2100
Wire Wire Line
	4150 1650 4150 2100
$Comp
L power:GND #PWR09
U 1 1 617BD824
P 4150 2100
F 0 "#PWR09" H 4150 1850 50  0001 C CNN
F 1 "GND" V 4155 1972 50  0000 R CNN
F 2 "" H 4150 2100 50  0001 C CNN
F 3 "" H 4150 2100 50  0001 C CNN
	1    4150 2100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3850 1650 4150 1650
Wire Wire Line
	3400 2050 3400 1950
Wire Wire Line
	3400 1950 3600 1950
Wire Wire Line
	2850 2050 3400 2050
Connection ~ 3600 1950
Wire Wire Line
	3400 2150 3400 2250
Wire Wire Line
	3400 2250 3600 2250
Wire Wire Line
	2850 2150 3400 2150
Connection ~ 3600 2250
Wire Wire Line
	2850 1950 3250 1950
Wire Wire Line
	2850 1850 3250 1850
Wire Wire Line
	1200 5200 1350 5200
Wire Wire Line
	2700 5200 2850 5200
$Comp
L power:GND #PWR02
U 1 1 617D9823
P 1350 5200
F 0 "#PWR02" H 1350 4950 50  0001 C CNN
F 1 "GND" H 1355 5027 50  0000 C CNN
F 2 "" H 1350 5200 50  0001 C CNN
F 3 "" H 1350 5200 50  0001 C CNN
	1    1350 5200
	1    0    0    -1  
$EndComp
Connection ~ 1350 5200
Wire Wire Line
	1350 5200 1550 5200
$Comp
L power:GND #PWR06
U 1 1 617D9E28
P 2850 5200
F 0 "#PWR06" H 2850 4950 50  0001 C CNN
F 1 "GND" H 2855 5027 50  0000 C CNN
F 2 "" H 2850 5200 50  0001 C CNN
F 3 "" H 2850 5200 50  0001 C CNN
	1    2850 5200
	1    0    0    -1  
$EndComp
Connection ~ 2850 5200
Wire Wire Line
	2850 5200 3050 5200
Wire Wire Line
	2850 1650 3250 1650
Wire Wire Line
	2850 1750 3250 1750
Text Label 3250 1650 2    50   ~ 0
BIN2
Text Label 3250 1750 2    50   ~ 0
BIN1
$Comp
L Connector:Conn_01x03_Male J3
U 1 1 61850E94
P 4450 5750
F 0 "J3" H 4558 6031 50  0000 C CNN
F 1 "MENCA" H 4558 5940 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B3B-XH-A_1x03_P2.50mm_Vertical" H 4450 5750 50  0001 C CNN
F 3 "~" H 4450 5750 50  0001 C CNN
	1    4450 5750
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x03_Male J4
U 1 1 6186A436
P 4450 6500
F 0 "J4" H 4558 6781 50  0000 C CNN
F 1 "MENCB" H 4558 6690 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B3B-XH-A_1x03_P2.50mm_Vertical" H 4450 6500 50  0001 C CNN
F 3 "~" H 4450 6500 50  0001 C CNN
	1    4450 6500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR010
U 1 1 6186D271
P 4950 5650
F 0 "#PWR010" H 4950 5400 50  0001 C CNN
F 1 "GND" V 4955 5522 50  0000 R CNN
F 2 "" H 4950 5650 50  0001 C CNN
F 3 "" H 4950 5650 50  0001 C CNN
	1    4950 5650
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR012
U 1 1 61876509
P 4950 6400
F 0 "#PWR012" H 4950 6150 50  0001 C CNN
F 1 "GND" V 4955 6272 50  0000 R CNN
F 2 "" H 4950 6400 50  0001 C CNN
F 3 "" H 4950 6400 50  0001 C CNN
	1    4950 6400
	0    -1   -1   0   
$EndComp
$Comp
L power:+3.3V #PWR011
U 1 1 6187AEE2
P 4950 5750
F 0 "#PWR011" H 4950 5600 50  0001 C CNN
F 1 "+3.3V" V 4965 5878 50  0000 L CNN
F 2 "" H 4950 5750 50  0001 C CNN
F 3 "" H 4950 5750 50  0001 C CNN
	1    4950 5750
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR013
U 1 1 61880926
P 4950 6500
F 0 "#PWR013" H 4950 6350 50  0001 C CNN
F 1 "+3.3V" V 4965 6628 50  0000 L CNN
F 2 "" H 4950 6500 50  0001 C CNN
F 3 "" H 4950 6500 50  0001 C CNN
	1    4950 6500
	0    1    1    0   
$EndComp
Wire Wire Line
	4650 5650 4950 5650
Wire Wire Line
	4650 5750 4950 5750
Wire Wire Line
	4650 6400 4950 6400
Wire Wire Line
	4650 6500 4950 6500
Wire Wire Line
	4650 5850 4950 5850
Wire Wire Line
	4650 6600 4900 6600
Text Label 4950 5850 2    50   ~ 0
INT0
Text Label 4900 6600 2    50   ~ 0
INT1
$Comp
L Connector:Conn_01x02_Male J7
U 1 1 617ED96B
P 6900 1600
F 0 "J7" H 7008 1781 50  0000 C CNN
F 1 "3V3IN" H 7008 1690 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 6900 1600 50  0001 C CNN
F 3 "~" H 6900 1600 50  0001 C CNN
	1    6900 1600
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H1
U 1 1 618CB622
P 7100 4050
F 0 "H1" H 7200 4096 50  0000 L CNN
F 1 "MountingHole" H 7200 4005 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.5mm_Pad_TopBottom" H 7100 4050 50  0001 C CNN
F 3 "~" H 7100 4050 50  0001 C CNN
	1    7100 4050
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 618E4922
P 7100 4300
F 0 "H2" H 7200 4346 50  0000 L CNN
F 1 "MountingHole" H 7200 4255 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.5mm_Pad_TopBottom" H 7100 4300 50  0001 C CNN
F 3 "~" H 7100 4300 50  0001 C CNN
	1    7100 4300
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 618E5159
P 7100 4500
F 0 "H3" H 7200 4546 50  0000 L CNN
F 1 "MountingHole" H 7200 4455 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.5mm_Pad_TopBottom" H 7100 4500 50  0001 C CNN
F 3 "~" H 7100 4500 50  0001 C CNN
	1    7100 4500
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 618E5809
P 7100 4700
F 0 "H4" H 7200 4746 50  0000 L CNN
F 1 "MountingHole" H 7200 4655 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.5mm_Pad_TopBottom" H 7100 4700 50  0001 C CNN
F 3 "~" H 7100 4700 50  0001 C CNN
	1    7100 4700
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D1
U 1 1 619000D3
P 7500 5850
F 0 "D1" H 7493 5595 50  0000 C CNN
F 1 "LED" H 7493 5686 50  0000 C CNN
F 2 "LED_SMD:LED_1206_3216Metric" H 7500 5850 50  0001 C CNN
F 3 "~" H 7500 5850 50  0001 C CNN
	1    7500 5850
	-1   0    0    1   
$EndComp
$Comp
L Device:R R2
U 1 1 61907597
P 7050 5850
F 0 "R2" V 6843 5850 50  0000 C CNN
F 1 "330" V 6934 5850 50  0000 C CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 6980 5850 50  0001 C CNN
F 3 "~" H 7050 5850 50  0001 C CNN
	1    7050 5850
	0    1    1    0   
$EndComp
Wire Wire Line
	7200 5850 7350 5850
$Comp
L power:+3.3V #PWR022
U 1 1 619161AD
P 6650 5850
F 0 "#PWR022" H 6650 5700 50  0001 C CNN
F 1 "+3.3V" H 6665 6023 50  0000 C CNN
F 2 "" H 6650 5850 50  0001 C CNN
F 3 "" H 6650 5850 50  0001 C CNN
	1    6650 5850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR023
U 1 1 61916873
P 7800 5850
F 0 "#PWR023" H 7800 5600 50  0001 C CNN
F 1 "GND" V 7805 5722 50  0000 R CNN
F 2 "" H 7800 5850 50  0001 C CNN
F 3 "" H 7800 5850 50  0001 C CNN
	1    7800 5850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7650 5850 7800 5850
Wire Wire Line
	6650 5850 6900 5850
Connection ~ 1200 4900
Wire Wire Line
	1200 4900 1550 4900
Wire Wire Line
	1000 4900 1200 4900
$Comp
L Device:C C1
U 1 1 617872A4
P 1200 5050
F 0 "C1" H 1315 5096 50  0000 L CNN
F 1 "0.1uf" H 1315 5005 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 1238 4900 50  0001 C CNN
F 3 "~" H 1200 5050 50  0001 C CNN
	1    1200 5050
	1    0    0    -1  
$EndComp
$EndSCHEMATC
