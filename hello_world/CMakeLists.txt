
cmake_minimum_required (VERSION 3.22)
project (vSomeIPHelloWorld)

find_package(Threads REQUIRED)

set(VSOMEIP_NAME "vsomeip3")

add_library(vsomeip_hello_world_service INTERFACE)
target_sources(vsomeip_hello_world_service INTERFACE
    "${CMAKE_CURRENT_SOURCE_DIR}/hello_world_service.hpp"
)
target_include_directories(vsomeip_hello_world_service INTERFACE
    "${CMAKE_CURRENT_SOURCE_DIR}"
)

add_library(vsomeip_hello_world_client INTERFACE)
target_sources(vsomeip_hello_world_client INTERFACE
    "${CMAKE_CURRENT_SOURCE_DIR}/hello_world_client.hpp"
)

target_include_directories(vsomeip_hello_world_client INTERFACE
    "${CMAKE_CURRENT_SOURCE_DIR}"
)

find_package(${VSOMEIP_NAME})

add_executable (hello_world_service hello_world_service_main.cpp)
target_link_libraries(hello_world_service vsomeip_hello_world_service ${VSOMEIP_NAME}-cfg ${VSOMEIP_NAME} ${CMAKE_THREAD_LIBS_INIT})

add_executable (hello_world_client hello_world_client_main.cpp)
target_link_libraries(hello_world_client vsomeip_hello_world_client ${VSOMEIP_NAME}-cfg ${VSOMEIP_NAME} ${CMAKE_THREAD_LIBS_INIT})
