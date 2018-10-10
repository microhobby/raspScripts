#!/bin/bash

RED='\x1b[42;37m'
NC='\033[0m' 

echo -e "${RED}CPU INFO${NC}"
echo "Author: Matheus Castello <matheus@mpro3.com.br>"
echo "Version: 0.1"
echo ""

echo -e "${RED}CORE INFO${NC}"

MODEL=`cat /proc/cpuinfo | grep "model name"`
VENDOR=`cat /proc/cpuinfo | grep "Hardware"`
TEMP=`cat /sys/class/thermal/thermal_zone0/temp`
TEMPVC=`/opt/vc/bin/vcgencmd measure_temp`
IFS=$'\n'; array=($MODEL); unset IFS;
IFS=$':'; array2=($VENDOR); unset IFS;
IFS=$'temp='; array3=($TEMPVC); unset IFS;

echo "CORES:	${#array[@]}"
echo "VENDOR: 	${array2[1]}"
echo "TEMP:	$TEMP"
echo "TEMPVC:	${array3[1]}"
echo ""

echo -e "${RED}RUN SYSBENCH${NC}"

echo Running ...
SYSBENCHRET=`sysbench --test=cpu --cpu-max-prime=2000 --num-threads=4 run`
echo Done

TEMP=`cat /sys/class/thermal/thermal_zone0/temp`
TEMPVC=`/opt/vc/bin/vcgencmd measure_temp`

echo ""
echo "$SYSBENCHRET" | grep "total time:"
echo ""
echo "TEMP:	$TEMP"
echo "TEMPVC:	$TEMPVC"
echo ""
echo "END"