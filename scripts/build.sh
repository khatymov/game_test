#!/bin/bash

build_dir="build"

if [ -f "CMakeUserPresets.json" ]; then
  rm "CMakeUserPresets.json" || exit $?
fi

if [ -d "${build_dir}" ]; then
  rm -rf "${build_dir}" || exit $?
fi

# Install dependencies
conan install . --output-folder="${build_dir}" --build=missing || exit $?

cd "${build_dir}" || exit $?

# Build
cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release || exit $?
cmake --build . --config Release || exit $?
make || exit $?