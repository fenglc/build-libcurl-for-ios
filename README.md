# build-libcurl-for-ios

## Usage

```
 curl -O http://curl.haxx.se/download/curl-7.45.0.tar.gz
 tar xf curl-7.45.0.tar.gz
 cd curl-7.45.0
 curl https://raw.githubusercontent.com/fenglc/build-libcurl-for-ios/master/build.sh | bash
 ......
```
or
```
mkdir build
cd build
cmake .. -G "Xcode" -DHTTP_ONLY=ON -DCMAKE_USE_OPENSSL=OFF -DBUILD_CURL_EXE=OFF -DBUILD_CURL_TESTS=OFF -DCURL_STATICLIB=ON
curl https://raw.githubusercontent.com/fenglc/build-libcurl-for-ios/master/build2.sh | bash
 ......
```
## See also

* http://web.archive.org/web/20151002200947/http://home.comcast.net/~seiryu/libcurl-ios.html
* https://github.com/sinofool/build-libcurl-ios
