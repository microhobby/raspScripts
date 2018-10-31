#!/bin/bash

GREEN='\x1b[42;37m'
RED='\033[0;31m'
NC='\033[0m' 

echo -e "${GREEN}GPU INFO${NC}"
echo "Author: Matheus Castello <matheus@castello.eng.br>"
echo "Version: 0.1"
echo ""

echo -e "${GREEN}GLX INFO${NC}"

SECOND="product"
PRODUCT=`sudo lshw | grep product`
MODEL=`glxinfo 2> /dev/null | grep "OpenGL vendor string:"`
OPENGL=`glxinfo 2> /dev/null | grep "OpenGL version string:"`
RENDER=`glxinfo 2> /dev/null | grep "OpenGL renderer string:"`
IFS=$':'; array1=($MODEL); unset IFS;
IFS=$':'; array2=($OPENGL); unset IFS;
IFS=$':'; array3=($RENDER); unset IFS;
IFS=$':'; array4=($PRODUCT); unset I

echo "VENDOR: 	${array1[1]}"
echo "GL VERSION: 	${array2[1]}"
echo "GL RENDERER: 	${array3[1]}"
echo ""

echo -e "${GREEN}RUN GLMARK${NC}"

TEMP=`cat /sys/class/thermal/thermal_zone0/temp`
TEMPVC=`/opt/vc/bin/vcgencmd measure_temp`
IFS=$'='; array3=($TEMPVC); unset IFS;
echo "Temp before: 	$TEMP"
echo "TEMPVC: 		${array3[1]}"

RESULT=`glmark2 -b refract:duration=10 2> /dev/null | grep "glmark2 Score:"`
IFS=$':'; array1=($RESULT); unset IFS;

echo -e "${RED}"
echo "Board: 	${array4[1]/$SECOND/}"
echo "Score: 	${array1[1]}"
echo -e "${NC}"

TEMP=`cat /sys/class/thermal/thermal_zone0/temp`
TEMPVC=`/opt/vc/bin/vcgencmd measure_temp`
IFS=$'='; array3=($TEMPVC); unset IFS;
echo "Temp before: 	$TEMP"
echo "TEMPVC: 		${array3[1]}"
echo ""
