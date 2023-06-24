#!/usr/bin/env bash
echo "Cloning dependencies"
git clone https://github.com/mvaisakh/gcc-arm64 --depth=1
git clone https://github.com/mvaisakh/gcc-arm --depth=1
git clone --depth=1 https://github.com/IamCOD3X/AnyKernel3.git AnyKernel
echo "Done"
IMAGE=$(pwd)/out/arch/arm64/boot/Image.gz-dtb
TANGGAL=$(date +"%F-%S")
START=$(date +"%s")
export CONFIG_PATH=$PWD/arch/arm64/configs/viper_nethunter_defconfig
PATH="$(pwd)/gcc-arm64/bin:$(pwd)/gcc-arm/bin:${PATH}" \
export ARCH=arm64
export USE_CCACHE=1
export KBUILD_BUILD_HOST=GCC
export KBUILD_BUILD_USER="COD3X"
# Kernel local name
export LOCALVERSION=-ViP3R🐍-v1.0-NetHunter-2k23

# Compile plox
function compile() {
   make O=out ARCH=arm64 viper_nethunter_defconfig 
     PATH="$(pwd)/gcc-arm64/bin:$(pwd)/gcc-arm/bin:${PATH}" \
       make -j$(nproc --all) O=out \
                             ARCH=arm64 \
                             CROSS_COMPILE=aarch64-elf- \
                             CROSS_COMPILE_ARM32=arm-eabi-
                             CONFIG_DEBUG_SECTION_MISMATCH=y
   cp out/arch/arm64/boot/Image.gz-dtb AnyKernel
}
# Zipping
function zipping() {
    cd AnyKernel || exit 1
   zip -r9 ViP3R-RMX1801-EAS-${TANGGAL}.zip *
    curl https://bashupload.com/ViP3R-RMX1801-EAS-${TANGGAL}.zip --data-binary @ViP3R-RMX1801-EAS-${TANGGAL}.zip
    cd ..
}
compile
zipping
END=$(date +"%s")
DIFF=$(($END - $START))
