#!/bin/bash

RED='\x1b[42;37m'
NC='\033[0m' 

echo -e "${RED}CPU INFO${NC}"
echo "Author: Matheus Castello <matheus@mpro3.com.br>"
echo "Version: 0.1"
echo ""

echo -e "${RED}CORE INFO${NC}"

MODEL=`cat /proc/cpuinfo | grep "model name"`
VENDOR=`cat /proc/cpuinfo | grep "hardware"`
TEMP=`cat /sys/class/thermal/thermal_zone0/temp`
IFS=$'\n'; array=($MODEL); unset IFS;

echo "CORES:	${#array[@]}"
echo "VENDOR: 	$VENDOR"
echo "TEMP:	$TEMP"
echo ""

echo -e "${RED}RUN SYSBENCH${NC}"

echo Running ...
SYSBENCHRET=`sysbench --test=cpu --cpu-max-prime=20000 --num-threads=4 run`
echo Done
echo ""
echo "$SYSBENCHRET" | grep "total time"
echo ""
echo "TEMP:	$TEMP"
echo ""
echo "END"