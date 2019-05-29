cmake_minimum_required(VERSION 3.12)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")
find_package(BoostCompute REQUIRED)

# dynamic build
add_library(mylib SHARED mylib.cpp)
include(GenerateExportHeader)
generate_export_header(mylib
    EXPORT_MACRO_NAME DLL_EXPORT
    EXPORT_FILE_NAME ${CMAKE_CURRENT_BINARY_DIR}/include/mylib_export.h)
target_include_directories(mylib PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_BINARY_DIR}/include
)
target_link_libraries(mylib PRIVATE
    BoostCompute::BoostCompute
)
add_executable(myexe myexe.cpp)
target_include_directories(myexe PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)
target_link_libraries(myexe PRIVATE
    mylib
)

# static build
add_library(mylib_static STATIC mylib.cpp)
target_include_directories(mylib_static PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_BINARY_DIR}/include
)
target_link_libraries(mylib_static PRIVATE
    BoostCompute::BoostCompute
)
add_executable(myexe_static myexe.cpp)
target_link_libraries(myexe_static PRIVATE
    mylib_static
)
target_compile_definitions(myexe_static PRIVATE MYLIB_STATIC_DEFINE)
