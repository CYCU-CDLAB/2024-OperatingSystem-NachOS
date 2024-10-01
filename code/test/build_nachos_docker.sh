#!/bin/sh

# build nachos
cd ../build.linux
make clean > /dev/null 2>&1
make -j > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Build success"
else
    echo "Build failed"
    exit 1
fi
rm -rf nachos.bin
cp nachos nachos.bin