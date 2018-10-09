#!/bin/bash

RED='\x1b[42;37m'
NC='\033[0m' 

echo -e "${RED}INSTALL BENCHMARK DEPENDENCIES${NC}"
echo "Author: Matheus Castello <matheus@mpro3.com.br>"
echo "Version: 0.1"
echo ""

sudo apt-get install sysbench xvfb mesa-utils

echo -e "${RED}MAKE AND INSTALL VIDEO CORE OPENGV EXAMPLES${NC}"

cd /opt/vc/src
make

echo "END"