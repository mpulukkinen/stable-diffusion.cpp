# Cross-compile Windows ARM64 CUDA on an x64 GitHub Actions runner.
# The CUDA compiler executes on x64; its host compiler and libraries target ARM64.
include(${CMAKE_CURRENT_LIST_DIR}/arm64-windows-llvm.cmake)

if(DEFINED CUDAToolkit_ROOT)
    file(TO_CMAKE_PATH "${CUDAToolkit_ROOT}" CUDA_ROOT)
elseif(DEFINED ENV{CUDA_PATH})
    file(TO_CMAKE_PATH "$ENV{CUDA_PATH}" CUDA_ROOT)
else()
    message(FATAL_ERROR "CUDAToolkit_ROOT or CUDA_PATH must point to a CUDA 13.4 toolkit with ARM64 libraries")
endif()

if(DEFINED ENV{VCToolsInstallDir})
    file(TO_CMAKE_PATH "$ENV{VCToolsInstallDir}" MSVC_TOOLS_ROOT)
    set(CMAKE_CUDA_HOST_COMPILER "${MSVC_TOOLS_ROOT}/bin/Hostx64/arm64/cl.exe" CACHE FILEPATH "")
endif()

set(CMAKE_CUDA_COMPILER "${CUDA_ROOT}/bin/nvcc.exe" CACHE FILEPATH "")
set(CMAKE_CUDA_FLAGS_INIT "-target-dir=arm64")

# FindCUDAToolkit otherwise tends to select x64 libraries on the x64 CI host.
set(CUDA_CUDART               "${CUDA_ROOT}/lib/arm64/cudart.lib"   CACHE FILEPATH "")
set(CUDA_cudart_LIBRARY       "${CUDA_ROOT}/lib/arm64/cudart.lib"   CACHE FILEPATH "")
set(CUDA_cublas_LIBRARY       "${CUDA_ROOT}/lib/arm64/cublas.lib"   CACHE FILEPATH "")
set(CUDA_cublasLt_LIBRARY     "${CUDA_ROOT}/lib/arm64/cublasLt.lib" CACHE FILEPATH "")
set(CUDA_cuda_driver_LIBRARY "${CUDA_ROOT}/lib/arm64/cuda.lib"     CACHE FILEPATH "")
