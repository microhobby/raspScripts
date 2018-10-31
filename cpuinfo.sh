#!/bin/bash

GREEN='\x1b[42;37m'
RED='\033[0;31m'
NC='\033[0m' 

echo -e "${GREEN}CPU INFO${NC}"
echo "Author: Matheus Castello <matheus@mpro3.com.br>"
echo "Version: 0.1"
echo ""

echo -e "${GREEN}CORE INFO${NC}"

MODEL=`cat /proc/cpuinfo | grep "model name"`
VENDOR=`cat /proc/cpuinfo | grep "Hardware"`
TEMP=`cat /sys/class/thermal/thermal_zone0/temp`
TEMPVC=`/opt/vc/bin/vcgencmd measure_temp`
IFS=$'\n'; array=($MODEL); unset IFS;
IFS=$':'; array2=($VENDOR); unset IFS;
IFS=$'='; array3=($TEMPVC); unset IFS;

echo "CORES:	${#array[@]}"
echo "VENDOR:${array2[1]}"
echo "TEMP:	$TEMP"
echo "TEMPVC:	${array3[1]}"
echo ""

echo -e "${GREEN}RUN SYSBENCH${NC}"

echo Running ...
SYSBENCHRET=`sysbench cpu --time=5 --threads=4 run`
echo Done

TEMP=`cat /sys/class/thermal/thermal_zone0/temp`
TEMPVC=`/opt/vc/bin/vcgencmd measure_temp`
IFS=$'='; array3=($TEMPVC); unset IFS;

echo ""
echo -e "${RED}"
echo "$SYSBENCHRET" | grep "total number of events:"
echo -e "${NC}"
echo ""
echo "TEMP:	$TEMP"
echo "TEMPVC:	${array3[1]}"
echo ""
echo "END"