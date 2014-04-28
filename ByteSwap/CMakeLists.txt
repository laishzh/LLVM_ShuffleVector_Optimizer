cmake_minimum_required(VERSION 2.8)

set( LLVM_DIR "/usr/share/llvm-3.4/cmake" )
set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${LLVM_DIR} )
set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")

set( CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/build)

set ( CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set ( CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set ( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
find_package(LLVM)
include(AddLLVM)
include(HandleLLVMOptions)
add_definitions(${LLVM_DEFINITIONS})
include_directories(${LLVM_INCLUDE_DIR})
link_directories(${LLVM_LIBRARY_DIR})

#MESSAGE("${LLVM_DEFINITIONS}")
#MESSAGE("${LLVM_INCLUDE_DIR}")
add_llvm_loadable_module( LLVMMyPass sfl_to_bswap.cpp)