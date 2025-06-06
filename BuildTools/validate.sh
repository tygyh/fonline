#!/bin/bash -e

CUR_DIR="$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)"
source $CUR_DIR/setup-env.sh

mkdir -p $FO_WORKSPACE
pushd $FO_WORKSPACE

if [[ $1 = "linux-client" ]]; then
    TARGET=linux
    BUILD_TARGET="-DFO_BUILD_CLIENT=1 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
elif [[ $1 = "linux-gcc-client" ]]; then
    TARGET=linux
    BUILD_TARGET="-DFO_BUILD_CLIENT=1 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
    USE_GCC=1
elif [[ $1 = "android-arm-client" ]]; then
    TARGET=android
    BUILD_TARGET="-DFO_BUILD_CLIENT=1 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
elif [[ $1 = "android-arm64-client" ]]; then
    TARGET=android-arm64
    BUILD_TARGET="-DFO_BUILD_CLIENT=1 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
elif [[ $1 = "android-x86-client" ]]; then
    TARGET=android-x86
    BUILD_TARGET="-DFO_BUILD_CLIENT=1 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
elif [[ $1 = "web-client" ]]; then
    TARGET=web
    BUILD_TARGET="-DFO_BUILD_CLIENT=1 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
elif [[ $1 = "mac-client" ]]; then
    TARGET=mac
    BUILD_TARGET="-DFO_BUILD_CLIENT=1 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0"
elif [[ $1 = "ios-client" ]]; then
    TARGET=ios
    BUILD_TARGET="-DFO_BUILD_CLIENT=1 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0"
elif [[ $1 = "linux-server" ]]; then
    TARGET=linux
    BUILD_TARGET="-DFO_BUILD_CLIENT=0 -DFO_BUILD_SERVER=1 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
elif [[ $1 = "linux-gcc-server" ]]; then
    TARGET=linux
    BUILD_TARGET="-DFO_BUILD_CLIENT=0 -DFO_BUILD_SERVER=1 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
    USE_GCC=1
elif [[ $1 = "linux-editor" ]]; then
    TARGET=linux
    BUILD_TARGET="-DFO_BUILD_CLIENT=0 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=1 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
elif [[ $1 = "linux-gcc-editor" ]]; then
    TARGET=linux
    BUILD_TARGET="-DFO_BUILD_CLIENT=0 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=1 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
    USE_GCC=1
elif [[ $1 = "linux-mapper" ]]; then
    TARGET=linux
    BUILD_TARGET="-DFO_BUILD_CLIENT=0 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=1 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
elif [[ $1 = "linux-gcc-mapper" ]]; then
    TARGET=linux
    BUILD_TARGET="-DFO_BUILD_CLIENT=0 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=1 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
    USE_GCC=1
elif [[ $1 = "linux-ascompiler" ]]; then
    TARGET=linux
    BUILD_TARGET="-DFO_BUILD_CLIENT=0 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=1 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
elif [[ $1 = "linux-gcc-ascompiler" ]]; then
    TARGET=linux
    BUILD_TARGET="-DFO_BUILD_CLIENT=0 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=1 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
    USE_GCC=1
elif [[ $1 = "linux-baker" ]]; then
    TARGET=linux
    BUILD_TARGET="-DFO_BUILD_CLIENT=0 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=1 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
elif [[ $1 = "linux-gcc-baker" ]]; then
    TARGET=linux
    BUILD_TARGET="-DFO_BUILD_CLIENT=0 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=1 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
    USE_GCC=1
elif [[ $1 = "unit-tests" ]]; then
    TARGET=linux
    BUILD_TARGET="-DFO_BUILD_CLIENT=0 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=1 -DFO_CODE_COVERAGE=0 -DCMAKE_BUILD_TYPE=Debug"
elif [[ $1 = "code-coverage" ]]; then
    TARGET=linux
    USE_GCC=1
    BUILD_TARGET="-DFO_BUILD_CLIENT=0 -DFO_BUILD_SERVER=0 -DFO_BUILD_EDITOR=0 -DFO_BUILD_MAPPER=0 -DFO_BUILD_ASCOMPILER=0 -DFO_BUILD_BAKER=0 -DFO_UNIT_TESTS=0 -DFO_CODE_COVERAGE=1 -DCMAKE_BUILD_TYPE=Debug"
else
    echo "Invalid argument"
    exit 1
fi

BUILD_DIR=validate-$1
mkdir -p $BUILD_DIR
cd $BUILD_DIR

CMAKE=cmake

if [[ $TARGET = "linux" ]]; then
	if [[ $USE_GCC = "1" ]]; then
		export CC=/usr/bin/gcc
		export CXX=/usr/bin/g++
	else
		export CC=/usr/bin/clang
		export CXX=/usr/bin/clang++
	fi

    $CMAKE -G "Unix Makefiles" $BUILD_TARGET "$FO_PROJECT_ROOT"
    $CMAKE --build . --config Debug --parallel

elif [[ $TARGET = "web" ]]; then
    source $FO_WORKSPACE/emsdk/emsdk_env.sh

    $CMAKE -G "Unix Makefiles" -C "$FO_ENGINE_ROOT/BuildTools/web.cache.cmake" $BUILD_TARGET "$FO_PROJECT_ROOT"
    $CMAKE --build . --config Debug --parallel

elif [[ $TARGET = "android" || $TARGET = "android-arm64" || $TARGET = "android-x86" ]]; then
    if [[ $TARGET = "android" ]]; then
        export ANDROID_ABI=armeabi-v7a
    elif [[ $TARGET = "android-arm64" ]]; then
        export ANDROID_ABI=arm64-v8a
    elif [[ $TARGET = "android-x86" ]]; then
        export ANDROID_ABI=x86
    fi

    $CMAKE -G "Unix Makefiles" -C "$FO_ENGINE_ROOT/BuildTools/android.cache.cmake" $BUILD_TARGET "$FO_PROJECT_ROOT"
    $CMAKE --build . --config Debug --parallel

elif [[ $TARGET = "mac" || $TARGET = "ios" ]]; then
    if [[ ! -x $(command -v cmake) ]]; then
        CMAKE=/Applications/CMake.app/Contents/bin/cmake
    fi

    if [[ $TARGET = "mac" ]]; then
        $CMAKE -G "Xcode" $BUILD_TARGET "$FO_PROJECT_ROOT"
    else
        $CMAKE -G "Xcode" -C "$FO_ENGINE_ROOT/BuildTools/ios.cache.cmake" $BUILD_TARGET "$FO_PROJECT_ROOT"
    fi

    $CMAKE --build . --config Debug --parallel
fi

if [[ $1 = "unit-tests" ]]; then
    echo "Run unit tests"
    $CMAKE --build . --config Debug --target RunUnitTests --parallel

elif [[ $1 = "code-coverage" ]]; then
    echo "Run code coverage"
    $CMAKE --build . --config Debug --target RunCodeCoverage --parallel

    if [[ ! -z $CODECOV_TOKEN ]]; then
        echo "Upload reports to codecov.io"
        rm -rf codecov
        curl -Os https://uploader.codecov.io/latest/linux/codecov
        chmod +x codecov
        ./codecov -t $CODECOV_TOKEN --gcov
    fi
fi

popd
