cmake_minimum_required(VERSION 3.22)

project(vsomeip_demo LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(FetchContent)

FetchContent_Declare(
    Vsomeip
    URL https://github.com/COVESA/vsomeip/archive/refs/tags/3.4.10.tar.gz
    DOWNLOAD_EXTRACT_TIMESTAMP ON
)

set(BOOST_INCLUDE_LIBRARIES asio thread filesystem system foreach property_tree icl)
FetchContent_MakeAvailable(Vsomeip)

# hacks
target_compile_definitions(vsomeip3 PRIVATE -DVSOMEIP_BASE_PATH=\"/vendor/run/someip/\")
target_compile_options(vsomeip3 PRIVATE -Wno-format-security)
target_link_libraries(vsomeip3 PRIVATE log)
target_include_directories(vsomeip3 PRIVATE include)

macro(remove_librt)
    foreach(target IN ITEMS ${ARGN})
        get_target_property(TARGET_LIBRARIES ${target} LINK_LIBRARIES)
        LIST(REMOVE_ITEM TARGET_LIBRARIES rt)
        set_property(TARGET ${target} PROPERTY LINK_LIBRARIES  ${TARGET_LIBRARIES})
    endforeach()
endmacro()

## hacks
remove_librt(vsomeip3 vsomeip3-cfg vsomeip3-sd vsomeip3-e2e)
