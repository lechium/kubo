#!/bin/bash
# -Wl,-sectcreate,__RESTRICT,__restrict,/dev/null

#set -e
# set trap to help debug any build errors
#trap "echo '** ERROR with build:'; pwd ; echo $?" INT TERM EXIT

#make build GOOS=darwin GOARCH=arm64 CC=/usr/local/bin/$CLANG CXX=/usr/local/bin/$CLANG GOTAGS="ios" CGO_CFLAGS="-isysroot $SDK_PATH -arch arm64 -I$SDK_PATH/usr/include" CGO_LDFLAGS="-isysroot $SDK_PATH -arch arm64 -L$SDK_PATH/usr/lib/ -I$GOPATH/pkg/mod/local/kubo/include" CGO_ENABLED=1

plat=$1
SDK=iphoneos
CLANG=clangwrap
OPENSSL=""
TAGS="tag1 ios"
if [ ! -z $plat ]; then
	echo $plat
	if [ $plat == "ios" ]; then
		SDK=iphoneos
		CLANG=clangwrap
	fi
	if [ $plat == "tvos" ]; then
		SDK=appletvos
        CLANG=clangtv
	fi
	echo $SDK
fi

while test $# -gt 0; do
	case "$1" in
		-h|--help)
			usage
			;;
		-o|--openssl)
            TAGS="tag1 ios openssl"
			OPENSSL="openssl"
			shift
			;;
   	*)
			break
			;;
	esac
done


SDK_PATH=`/usr/bin/xcrun --sdk $SDK --show-sdk-path`

name="ipfs"

#echo $SDK_PATH

GOOS=darwin GOARCH=arm64 CC=/usr/local/bin/$CLANG CXX=/usr/local/bin/$CLANG GOTAGS=$OPENSSL CGO_CFLAGS="-isysroot $SDK_PATH -arch arm64 -I$SDK_PATH/usr/include" CGO_LDFLAGS="-isysroot $SDK_PATH -arch arm64 -L$SDK_PATH/usr/lib/ -I$GOPATH/pkg/mod/local/kubo/inc -L$GOPATH/pkg/mod/local/kubo/lib/" CGO_ENABLED=1 go build -pkgdir=$GOPATH/pkg/gomobile/pkg_darwin_arm64 -tags "$TAGS" -x -o=$name local/kubo/cmd/ipfs&&

ldid -Sent.plist $name
