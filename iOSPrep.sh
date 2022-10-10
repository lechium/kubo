#!/bin/bash

SDK=iphoneos
SDK_PATH=$(/usr/bin/xcrun --sdk $SDK --show-sdk-path)
SDK_INC="$SDK_PATH"/usr/include/
cp clangwrap /usr/local/bin/
cp clangtv /usr/local/bin/
cp inc/sys/kern_control.h inc/sys/proc_info.h "$SDK_INC"/sys/
cp inc/libproc.h "$SDK_INC"/
cp inc/net/route.h "$SDK_INC"/net/

