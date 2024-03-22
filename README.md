# Build vsomeip library for Android

## Run

make sure $ANDROID_NDK_HOME point to NDK home

```sh
cmake -B ./build -G Ninja -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake -DANDROID_ABI=arm64-v8a -S .
cmake --build ./build
```
