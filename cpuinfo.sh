#!/bin/bash

GREEN='\x1b[42;37m'
RED='\033[0;31m'
NC='\033[0m' 

echo -e "${GREEN}CPU INFO${NC}"
echo "Author: Matheus Castello <matheus@mpro3.com.br>"
echo "Version: 0.1"
echo ""

echo -e "${GREEN}CORE INFO${NC}"

SECOND="product"
PRODUCT=`sudo lshw | grep product`
MODEL=`cat /proc/cpuinfo | grep "model name"`
VENDOR=`cat /proc/cpuinfo | grep "Hardware"`
TEMP=`cat /sys/class/thermal/thermal_zone0/temp`
TEMPVC=`/opt/vc/bin/vcgencmd measure_temp`
IFS=$'\n'; array=($MODEL); unset IFS;
IFS=$':'; array2=($VENDOR); unset IFS;
IFS=$'='; array3=($TEMPVC); unset IFS;
IFS=$':'; array4=($PRODUCT); unset I

echo "CORES:	${#array[@]}"
echo "VENDOR:${array2[1]}"
echo "TEMP:	$TEMP"
echo "TEMPVC:	${array3[1]}"
echo ""

echo -e "${GREEN}RUN SYSBENCH${NC}"

echo Running ...
SYSBENCHRET=`sysbench --test=cpu --num-threads=4 --cpu-max-prime=2000 run 2> /dev/null`
echo Done

TEMP=`cat /sys/class/thermal/thermal_zone0/temp`
TEMPVC=`/opt/vc/bin/vcgencmd measure_temp`
IFS=$'='; array3=($TEMPVC); unset IFS;

echo ""
echo -e "${RED}"
echo "Board: 	${array4[1]/$SECOND/}"
echo "$SYSBENCHRET" | grep "total time:"
echo -e "${NC}"
echo ""
echo "TEMP:	$TEMP"
echo "TEMPVC:	${array3[1]}"
echo ""
echo "END"
