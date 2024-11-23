export TZ='Asia/Jakarta'
BUILDDATE=$(date +%Y%m%d)
NAME=Swordx-Juzumaru
# BUILDTIME=$(date +%H%M)

# Install dependencies
sudo apt update && sudo apt install -y bc cpio nano bison ca-certificates curl flex gcc git libc6-dev libssl-dev openssl python-is-python3 ssh wget zip zstd sudo make clang gcc-arm-linux-gnueabi software-properties-common build-essential libarchive-tools gcc-aarch64-linux-gnu

# Using Rastamod-Clang
# wget https://github.com/kutemeikito/RastaMod69-Clang/releases/download/RastaMod69-Clang-20.0.0-release/RastaMod69-Clang-20.0.0.tar.gz
# Move & Extract Clang
mkdir clang && tar -xf RastaMod69-Clang-20.0.0.tar.gz -C clang && rm -rf RastaMod69-Clang-20.0.0.tar.gz

# Set variable
export KBUILD_BUILD_USER=kiddie
export KBUILD_BUILD_HOST=ubuntu

    # Build
    # Prepare
    make -j$(nproc --all) O=out ARCH=arm64 CC=$(pwd)/clang/bin/clang CROSS_COMPILE=aarch64-linux-gnu- CLANG_TRIPLE=aarch64-linux-gnu- LLVM_IAS=1 vendor/fog-perf_defconfig
    # Execute
    make -j$(nproc --all) O=out ARCH=arm64 CC=$(pwd)/clang/bin/clang CROSS_COMPILE=aarch64-linux-gnu- CLANG_TRIPLE=aarch64-linux-gnu- LLVM_IAS=1

    # Package
    git clone --depth=1 https://github.com/ardia-kun/AnyKernel3-680 -b ksu AnyKernel3
    cp -R out/arch/arm64/boot/Image.gz AnyKernel3/Image.gz
    # Zip it and upload it
    cd AnyKernel3
    zip -r9 $NAME+KSU-"$BUILDDATE" . -x ".git*" -x "README.md" -x "*.zip"
    curl -T $NAME+KSU-"$BUILDDATE".zip -u :d8fce976-eb03-4c70-be68-aaeb1fe8fced https://pixeldrain.com/api/file/
    # finish
    cd ..
    rm -rf clang-llvm/ AnyKernel3/
    echo "Build finished"
