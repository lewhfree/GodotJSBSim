To build JSBSim (I know its a brute force):
```
  cmake .. \
  -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_ROOT/build/cmake/android.toolchain.cmake \
  -DANDROID_ABI=arm64-v8a \
  -DANDROID_PLATFORM=android-24 \
  -DANDROID_STL=c++_shared \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_C_FLAGS="-include sys/socket.h -include netinet/in.h -include arpa/inet.h" \
  -DCMAKE_CXX_FLAGS="-include sys/socket.h -include netinet/in.h -include arpa/inet.h"
```

```
  scons platform=android target=template_debug arch=arm64 android_arch=arm64
```
