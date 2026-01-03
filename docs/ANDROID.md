To build JSBSim (I know its a brute force):
```
  cmake .. \
    -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_ROOT/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=arm64-v8a \
    -DANDROID_PLATFORM=android-24 \
    -DCMAKE_CXX_FLAGS="-D__linux__ -include sys/socket.h -include netinet/in.h -include arpa/inet.h -include unistd.h" \
    -DCMAKE_C_FLAGS="-D__linux__ -include sys/socket.h -include netinet/in.h -include arpa/inet.h -include unistd.h" \
    -DBUILD_SHARED_LIBS=ON

  make
```
