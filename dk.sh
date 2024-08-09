#!/bin/sh

DEFCONFIG="dkkernel/dk_defconfig"
CLANGDIR="/workspace/rvclang-20"

#
rm -rf compile.log

#
mkdir -p out
mkdir out/DkKernel
mkdir out/DkKernel/NSE_OC1_old
mkdir out/DkKernel/NSE_OC1_new
mkdir out/DkKernel/NSE_OC2_old
mkdir out/DkKernel/NSE_OC2_new
mkdir out/DkKernel/SE_OC1_old
mkdir out/DkKernel/SE_OC1_new
mkdir out/DkKernel/SE_OC2_old
mkdir out/DkKernel/SE_OC2_new


#
export KBUILD_BUILD_USER=DK_PROJECT
export KBUILD_BUILD_HOST=Bandar-Lampung 
export PATH="$CLANGDIR/bin:$PATH"

#
make O=out ARCH=arm64 $DEFCONFIG

#
MAKE="./makeparallel"

#
START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'

rve () {
make -j$(nproc --all) O=out LLVM=1 \
ARCH=arm64 \
CC=clang \
LD=ld.lld \
AR=llvm-ar \
AS=llvm-as \
NM=llvm-nm \
OBJCOPY=llvm-objcopy \
OBJDUMP=llvm-objdump \
STRIP=llvm-strip \
CROSS_COMPILE=aarch64-linux-gnu- \
CROSS_COMPILE_ARM32=arm-linux-gnueabi-
}

NSE_OC1_old() {
cp DkKernel/NSE/* arch/arm64/boot/dts/qcom/
cp DkKernel/OC/800/sdm845-v2.dtsi arch/arm64/boot/dts/qcom/
cp DkKernel/OC/800/gpucc-sdm845.c drivers/clk/qcom/
cp DkKernel/fw-touch-9.1.24/* firmware/
rve
    if [ $? -ne 0 ]
    then
        echo "Build failed"
    else
        echo "Build succesful"
        cp out/arch/arm64/boot/Image.gz-dtb out/DkKernel/NSE_OC1_old/Image.gz-dtb
    fi
}

NSE_OC1_new() {
cp DkKernel/NSE/* arch/arm64/boot/dts/qcom/
cp DkKernel/OC/800/sdm845-v2.dtsi arch/arm64/boot/dts/qcom/
cp DkKernel/OC/800/gpucc-sdm845.c drivers/clk/qcom/
cp DkKernel/fw-touch-10.3.7/* firmware/
rve
    if [ $? -ne 0 ]
    then
        echo "Build failed"
    else
        echo "Build succesful"
        cp out/arch/arm64/boot/Image.gz-dtb out/DkKernel/NSE_OC1_new/Image.gz-dtb
    fi
}

NSE_OC2_old() {
cp DkKernel/NSE/* arch/arm64/boot/dts/qcom/
cp DkKernel/OC/835/sdm845-v2.dtsi arch/arm64/boot/dts/qcom/
cp DkKernel/OC/835/gpucc-sdm845.c drivers/clk/qcom/
cp DkKernel/fw-touch-9.1.24/* firmware/
rve
    if [ $? -ne 0 ]
    then
        echo "Build failed"
    else
        echo "Build succesful"
        cp out/arch/arm64/boot/Image.gz-dtb out/DkKernel/NSE_OC2_old/Image.gz-dtb
    fi
}

NSE_OC2_new() {
cp DkKernel/NSE/* arch/arm64/boot/dts/qcom/
cp DkKernel/OC/835/sdm845-v2.dtsi arch/arm64/boot/dts/qcom/
cp DkKernel/OC/835/gpucc-sdm845.c drivers/clk/qcom/
cp DkKernel/fw-touch-10.3.7/* firmware/
rve
    if [ $? -ne 0 ]
    then
        echo "Build failed"
    else
        echo "Build succesful"
        cp out/arch/arm64/boot/Image.gz-dtb out/DkKernel/NSE_OC2_new/Image.gz-dtb
    fi
}

SE_OC1_old() {
cp DkKernel/SE/* arch/arm64/boot/dts/qcom/
cp DkKernel/OC/800/sdm845-v2.dtsi arch/arm64/boot/dts/qcom/
cp DkKernel/OC/800/gpucc-sdm845.c drivers/clk/qcom/
cp DkKernel/fw-touch-9.1.24/* firmware/
rve
    if [ $? -ne 0 ]
    then
        echo "Build failed"
    else
        echo "Build succesful"
        cp out/arch/arm64/boot/Image.gz-dtb out/DkKernel/SE_OC1_old/Image.gz-dtb
    fi
}

SE_OC1_new() {
cp DkKernel/SE/* arch/arm64/boot/dts/qcom/
cp DkKernel/OC/800/sdm845-v2.dtsi arch/arm64/boot/dts/qcom/
cp DkKernel/OC/800/gpucc-sdm845.c drivers/clk/qcom/
cp DkKernel/fw-touch-10.3.7/* firmware/
rve
    if [ $? -ne 0 ]
    then
        echo "Build failed"
    else
        echo "Build succesful"
        cp out/arch/arm64/boot/Image.gz-dtb out/DkKernel/SE_OC1_new/Image.gz-dtb
    fi
}

SE_OC2_old() {
cp DkKernel/SE/* arch/arm64/boot/dts/qcom/
cp DkKernel/OC/835/sdm845-v2.dtsi arch/arm64/boot/dts/qcom/
cp DkKernel/OC/835/gpucc-sdm845.c drivers/clk/qcom/
cp DkKernel/fw-touch-9.1.24/* firmware/
rve
    if [ $? -ne 0 ]
    then
        echo "Build failed"
    else
        echo "Build succesful"
        cp out/arch/arm64/boot/Image.gz-dtb out/DkKernel/SE_OC2_old/Image.gz-dtb
    fi
}

SE_OC2_new() {
cp DkKernel/SE/* arch/arm64/boot/dts/qcom/
cp DkKernel/OC/835/sdm845-v2.dtsi arch/arm64/boot/dts/qcom/
cp DkKernel/OC/835/gpucc-sdm845.c drivers/clk/qcom/
cp DkKernel/fw-touch-10.3.7/* firmware/
rve
    if [ $? -ne 0 ]
    then
        echo "Build failed"
    else
        echo "Build succesful"
        cp out/arch/arm64/boot/Image.gz-dtb out/DkKernel/SE_OC2_new/Image.gz-dtb
    fi
}

NSE_OC1_old
NSE_OC1_new
NSE_OC2_old
NSE_OC2_new
SE_OC1_old
SE_OC1_new
SE_OC2_old
SE_OC2_new

END=$(date +"%s")
DIFF=$(($END - $START))
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
