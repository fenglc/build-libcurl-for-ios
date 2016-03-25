#!/bin/sh

 export OUTDIR=`pwd`/buildlib

function build(){
 ARCH=$1
 SDKDIR=$2

 xcodebuild -project 'CURL.xcodeproj' -configuration 'Release' -sdk ${SDKDIR} clean build ARCHS=${ARCH} IPHONEOS_DEPLOYMENT_TARGET='7.0' TARGET_BUILD_DIR=${OUTDIR} BUILT_PRODUCTS_DIR=${OUTDIR}

 
 mv $OUTDIR/libcurl.a $OUTDIR/libcurl-${ARCH}.a

}

 mkdir -p $OUTDIR

 build armv7   `xcrun --sdk iphoneos --show-sdk-path`
 build armv7s  `xcrun --sdk iphoneos --show-sdk-path`
 build arm64   `xcrun --sdk iphoneos --show-sdk-path`
 build i386    `xcrun --sdk iphonesimulator --show-sdk-path`
 build x86_64  `xcrun --sdk iphonesimulator --show-sdk-path`

 lipo -arch armv7 $OUTDIR/libcurl-armv7.a \
    -arch armv7s $OUTDIR/libcurl-armv7s.a \
    -arch arm64 $OUTDIR/libcurl-arm64.a \
    -arch i386 $OUTDIR/libcurl-i386.a \
    -arch x86_64 $OUTDIR/libcurl-x86_64.a \
    -create -output $OUTDIR/libcurl_all.a

 ls $OUTDIR
