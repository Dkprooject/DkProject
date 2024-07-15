#!/bin/sh

DEFCONFIG="hvkernel/hvkernel_defconfig"
CLANGDIR="/workspace/clang"

#
rm -rf compile.log

#
mkdir -p out
mkdir out/HvKernel
mkdir out/HvKernel/NSE_OC
mkdir out/HvKernel/NSE_Stock
mkdir out/HvKernel/SE_OC
mkdir out/HvKernel/SE_Stock



#
export KBUILD_BUILD_USER=Hkadaaa
export KBUILD_BUILD_HOST=Builder
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
CC="ccache clang" \
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

nse_oc() {
cp HvKernel/NSE/* arch/arm64/boot/dts/qcom/
cp HvKernel/OC/sdm845-v2.dtsi arch/arm64/boot/dts/qcom/
cp HvKernel/OC/gpucc-sdm845.c drivers/clk/qcom/
rve 2>&1 | tee -a compile.log
    if [ $? -ne 0 ]
    then
        echo "Build failed"
    else
        echo "Build succesful"
        cp out/arch/arm64/boot/Image.gz-dtb out/HvKernel/NSE_OC/Image.gz-dtb
    fi
}

nse_stock() {
cp HvKernel/NSE/* arch/arm64/boot/dts/qcom/
cp HvKernel/STOCK/sdm845-v2.dtsi arch/arm64/boot/dts/qcom/
cp HvKernel/STOCK/gpucc-sdm845.c drivers/clk/qcom/
rve
    if [ $? -ne 0 ]
    then
        echo "Build failed"
    else
        echo "Build succesful"
        cp out/arch/arm64/boot/Image.gz-dtb out/HvKernel/NSE_Stock/Image.gz-dtb
    fi
}

se_oc() {
cp HvKernel/SE/* arch/arm64/boot/dts/qcom/
cp HvKernel/OC/sdm845-v2.dtsi arch/arm64/boot/dts/qcom/
cp HvKernel/OC/gpucc-sdm845.c drivers/clk/qcom/
rve
    if [ $? -ne 0 ]
    then
        echo "Build failed"
    else
        echo "Build succesful"
        cp out/arch/arm64/boot/Image.gz-dtb out/RvKernel/SE_OC/Image.gz-dtb
    fi
}

se_stock() {
cp HvKernel/SE/* arch/arm64/boot/dts/qcom/
cp HvKernel/STOCK/sdm845-v2.dtsi arch/arm64/boot/dts/qcom/
cp HvKernel/STOCK/gpucc-sdm845.c drivers/clk/qcom/
rve
    if [ $? -ne 0 ]
    then
        echo "Build failed"
    else
        echo "Build succesful"
        cp out/arch/arm64/boot/Image.gz-dtb out/HvKernel/SE_Stock/Image.gz-dtb
    fi
}

nse_oc
nse_stock
se_oc
se_stock

END=$(date +"%s")
DIFF=$(($END - $START))
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
