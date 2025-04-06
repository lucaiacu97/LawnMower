#!/bin/bash

read -p "Functionality: " functionality

if [ ! -d "Scripts/Core/Common/$functionality" ]; then
    echo "$functionality folder doesn't exist"
    exit 1
fi

starting_dir=$(pwd)
cd D:/LawnMower || exit 1

functionality_path="Scripts/Core/Common/$functionality"
src_folder="$functionality_path/src"
include_folder="$functionality_path/include"
libs_list="$functionality_path/external_libraries.txt"
ext_libs_path="Ext_libs"

# Common include flags
include_flags="-I$include_folder"
library_flags=""

# Parse external libraries
while read -r lib_name; do
    if [ -n "$lib_name" ]; then
        include_flags="$include_flags -I$ext_libs_path/$lib_name/include"
        library_flags="$library_flags -L$ext_libs_path/$lib_name/lib -l$lib_name"
    fi
done < "$libs_list"

# 1. STM32 (static lib for C on microcontroller)
echo "Building for STM32..."
build_folder_stm="$functionality_path/build_stm32"
mkdir -p "$build_folder_stm"
for src in "$src_folder"/*.c; do
    src_name=$(basename "$src" .c)
    arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -Os -c "$src" $include_flags -o "$build_folder_stm/$src_name.o"
done
arm-none-eabi-ar rcs "$build_folder_stm/lib$functionality.a" "$build_folder_stm/"*.o
cp "$build_folder_stm/lib$functionality.a" "Scripts/Core/Mower/SharedLibraries/"
echo "STM32 static lib created"

# 2. Raspberry Pi (shared lib for Python via ctypes or CFFI)
echo "Building for Raspberry Pi..."
build_folder_pi="$functionality_path/build_rpi"
mkdir -p "$build_folder_pi"
for src in "$src_folder"/*.c; do
    src_name=$(basename "$src" .c)
    arm-linux-gnueabihf-gcc -fPIC -c "$src" $include_flags -o "$build_folder_pi/$src_name.o"
done
arm-linux-gnueabihf-gcc -shared -o "$build_folder_pi/lib$functionality.so" "$build_folder_pi"/*.o $library_flags
cp "$build_folder_pi/lib$functionality.so" "Scripts/Core/Station/SharedLibraries/"
echo "Raspberry Pi shared lib created"

# 3. Android (shared lib for C# via JNI or Unity Native Plugins)
echo "Building for Android..."
build_folder_android="$functionality_path/build_android"
mkdir -p "$build_folder_android"
for src in "$src_folder"/*.c; do
    src_name=$(basename "$src" .c)
    $ANDROID_NDK/toolchains/llvm/prebuilt/windows-x86_64/bin/clang --target=armv7a-linux-androideabi21 -fPIC -c "$src" $include_flags -o "$build_folder_android/$src_name.o"
done
$ANDROID_NDK/toolchains/llvm/prebuilt/windows-x86_64/bin/clang --target=armv7a-linux-androideabi21 -shared -o "$build_folder_android/lib$functionality.so" "$build_folder_android"/*.o $library_flags
cp "$build_folder_android/lib$functionality.so" "Scripts/Core/UserApp/SharedLibraries/"
echo "Android shared lib created"

cd "$starting_dir"
echo "Finished"
