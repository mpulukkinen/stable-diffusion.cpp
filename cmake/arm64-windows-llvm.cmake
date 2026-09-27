set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR arm64)

set(target arm64-pc-windows-msvc)

# Host tools run on the x64 GitHub runner, but all compiled outputs target ARM64.
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_ASM_COMPILER clang)

set(CMAKE_C_COMPILER_TARGET ${target})
set(CMAKE_CXX_COMPILER_TARGET ${target})
set(CMAKE_ASM_COMPILER_TARGET ${target})

# Prevent CMake cross-compile checks from attempting to execute ARM64 binaries
# on the x64 build host. Static-library checks are sufficient for compiler tests.
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(arch_c_flags "-march=armv8.7-a -fvectorize -ffp-model=fast -fno-finite-math-only")
set(warn_c_flags "-Wno-format -Wno-unused-variable -Wno-unused-function -Wno-gnu-zero-variadic-macro-arguments")

set(CMAKE_C_FLAGS_INIT "${arch_c_flags} ${warn_c_flags}")
set(CMAKE_CXX_FLAGS_INIT "${arch_c_flags} ${warn_c_flags}")
set(CMAKE_ASM_FLAGS_INIT "--target=${target}")
