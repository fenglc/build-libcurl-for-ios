
#!/bin/sh

 export OUTDIR=buildlib
 export IPHONEOS_DEPLOYMENT_TARGET="6.0"
 export CC=`xcrun -find -sdk iphoneos clang`

function build(){
 ARCH=$1
 HOST=$2
 SDKDIR=$3

 export CFLAGS="-arch ${ARCH} -pipe -Os -gdwarf-2 -isysroot ${SDKDIR} -miphoneos-version-min=${IPHONEOS_DEPLOYMENT_TARGET} -fembed-bitcode"

 export LDFLAGS="-arch ${ARCH} -isysroot ${SDKDIR}"

 ./configure --host="${HOST}-apple-darwin" --disable-shared --enable-static --disable-smtp --disable-pop3 --disable-imap --disable-ftp --disable-tftp --disable-telnet --disable-rtsp --disable-ldap

 make -j `sysctl -n hw.logicalcpu_max`
 cp lib/.libs/libcurl.a $OUTDIR/libcurl-${ARCH}.a

 make clean
}

 mkdir -p $OUTDIR

 build armv7   armv7   `xcrun --sdk iphoneos --show-sdk-path`
 build armv7s  armv7s  `xcrun --sdk iphoneos --show-sdk-path`
 build arm64    arm    `xcrun --sdk iphoneos --show-sdk-path`
 build i386    i386   `xcrun --sdk iphonesimulator --show-sdk-path`
 build x86_64  x86_64  `xcrun --sdk iphonesimulator --show-sdk-path`

 lipo -arch armv7 $OUTDIR/libcurl-armv7.a \
    -arch armv7s $OUTDIR/libcurl-armv7s.a \
    -arch arm64 $OUTDIR/libcurl-arm64.a \
    -arch i386 $OUTDIR/libcurl-i386.a \
    -arch x86_64 $OUTDIR/libcurl-x86_64.a \
    -create -output $OUTDIR/libcurl_all.a

 ls $OUTDIR
