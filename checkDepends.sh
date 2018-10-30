#!/bin/bash

GREEN='\x1b[42;37m'
RED='\033[0;31m'
NC='\033[0m' 

echo -e "${GREEN}INSTALL BENCHMARK DEPENDENCIES${NC}"
echo "Author: Matheus Castello <matheus@mpro3.com.br>"
echo "Version: 0.1"
echo ""

sudo apt-get install sysbench xvfb mesa-utils git g++ build-essential pkg-config -y
sudo apt-get install libx11-dev libgl1-mesa-dev -y
sudo apt-get install libjpeg-dev libpng-dev -y
sudo apt install meson libvulkan-dev libglm-dev libassimp-dev libxcb1-dev libxcb-icccm4-dev libwayland-dev libdrm-dev libgbm-dev

echo -e "${GREEN}MAKE AND INSTALL VULKAN BENCHMARK${NC}"

cd ~
git clone https://github.com/vkmark/vkmark.git
cd vkmark

echo "config ..."
meson build
mesonconf [-Dopt=val] build

echo "building ..."
ninja -C build

echo -e "${GREEN}MAKE AND INSTALL VIDEO CORE OPENGV EXAMPLES${NC}"

cd ~
git clone https://github.com/glmark2/glmark2.git
cd glmark2/

echo "config ..."
./waf configure --with-flavors=x11-gl

echo "building ..."
./waf build -j 4

echo "installing ..."
sudo ./waf install
sudo strip -s /usr/local/bin/glmark2

echo ""

echo -e "${GREEN}MAKE AND INSTALL VIDEO CORE OPENGV EXAMPLES${NC}"

cd /opt/vc/src/hello_pi
make

echo "END"
