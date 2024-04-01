if (CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
    cmake_policy(SET CMP0135 NEW)
endif()

include(FetchContent)

FetchContent_Declare(
    Vsomeip
    URL https://github.com/COVESA/vsomeip/archive/refs/tags/3.4.10.tar.gz
    # DOWNLOAD_EXTRACT_TIMESTAMP ON
)

set(BOOST_INCLUDE_LIBRARIES asio thread filesystem system foreach property_tree icl)

set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)

message("CMAKE_CXX_FLAGS is ${CMAKE_CXX_FLAGS}")

FetchContent_MakeAvailable(Vsomeip)

macro(remove_librt)
    foreach(target IN ITEMS ${ARGN})
        get_target_property(TARGET_LIBRARIES ${target} LINK_LIBRARIES)
        LIST(REMOVE_ITEM TARGET_LIBRARIES rt)
        set_property(TARGET ${target} PROPERTY LINK_LIBRARIES  ${TARGET_LIBRARIES})
    endforeach()
endmacro()

macro(unset_interface_link_libs)
    foreach(target IN ITEMS ${ARGN})
        set_property(TARGET ${target} PROPERTY INTERFACE_LINK_LIBRARIES)
    endforeach()
endmacro()

## hacks

if (${CMAKE_SYSTEM_NAME} MATCHES "Android")

    target_compile_definitions(vsomeip3 PRIVATE -DVSOMEIP_BASE_PATH=\"/data/local/tmp/\")
    target_compile_options(vsomeip3 PRIVATE -Wno-format-security)
    target_link_libraries(vsomeip3 PRIVATE log)
    target_include_directories(vsomeip3 PRIVATE ${CMAKE_CURRENT_LIST_DIR}/include)

    remove_librt(vsomeip3 vsomeip3-cfg vsomeip3-sd vsomeip3-e2e)
    unset_interface_link_libs(vsomeip3 vsomeip3-cfg vsomeip3-sd vsomeip3-e2e)

    target_link_libraries(vsomeip3 PUBLIC log)
endif()

target_compile_options(vsomeip3 PRIVATE -Wno-conversion -Wno-error)
target_compile_options(vsomeip3-cfg PRIVATE -Wno-conversion)
target_compile_options(vsomeip3-sd PRIVATE -Wno-conversion)

