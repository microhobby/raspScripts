#!/bin/bash

GREEN='\x1b[42;37m'
RED='\033[0;31m'
NC='\033[0m' 

echo -e "${GREEN}INSTALL BENCHMARK DEPENDENCIES${NC}"
echo "Author: Matheus Castello <matheus@mpro3.com.br>"
echo "Version: 0.1"
echo ""

sudo apt-get install sysbench xvfb mesa-utils

echo -e "${GREEN}MAKE AND INSTALL VIDEO CORE OPENGV EXAMPLES${NC}"

cd /opt/vc/src/hello_pi
make

echo "END"