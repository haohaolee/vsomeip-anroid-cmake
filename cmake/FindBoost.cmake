if (CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
    cmake_policy(SET CMP0135 NEW)
endif()

include(FetchContent)

FetchContent_Declare(
    Boost
    URL https://github.com/boostorg/boost/releases/download/boost-1.84.0/boost-1.84.0.tar.xz
    # DOWNLOAD_EXTRACT_TIMESTAMP ON
)

FetchContent_MakeAvailable(Boost)

set(Boost_VERSION 108400)
set(Boost_FOUND True)

foreach(comp ${BOOST_INCLUDE_LIBRARIES})
    list(APPEND Boost_LIBRARIES Boost::${comp})
endforeach()
