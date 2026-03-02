function setup_toolchain() {
  sudo apt install -y tree
  cd $HOME
  echo "DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG"
  pwd
  echo "DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG"
  ls
  echo "DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG"
  wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/tags/android-14.0.0_r18/clang-r487747c.tar.gz
  mkdir toolchain
  cd toolchain
  tar xvf ../clang-r487747c.tar.gz
  export PATH="$HOME/toolchain/bin:$PATH"
  echo "DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG"
  clang --version
  echo "DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG"
  pwd
  echo "DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG"
  ls
  echo "DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG"
  tree -L 3
  echo "DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG"
}

function build() {
  export ARCH=arm64
  export SUBARCH=arm64
  export LLVM=1
  export LLVM_IAS=1
  export CLANG_TRIPLE=aarch64-linux-gnu-
  export CROSS_COMPILE=aarch64-linux-android-
  
  make ARCH=arm64 SUBARCH=arm64 LLVM=1 LLVM_IAS=1 CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- clean
  make ARCH=arm64 SUBARCH=arm64 LLVM=1 LLVM_IAS=1 CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- mrproper
  make ARCH=arm64 SUBARCH=arm64 LLVM=1 LLVM_IAS=1 CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- O=out lavender_defconfig
  make ARCH=arm64 SUBARCH=arm64 LLVM=1 LLVM_IAS=1 CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- O=out -j${nproc}
}

setup_toolchain
build
