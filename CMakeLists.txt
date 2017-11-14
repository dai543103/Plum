project(Pulm)

cmake_minimum_required(VERSION 2.8)

add_definitions("-DASIO_STANDALONE")

if(WIN32)
    add_definitions("-D_WIN32_WINNT=0x0600")
    include_directories(${CMAKE_SOURCE_DIR}/thirdpart/include)
    link_directories(${CMAKE_SOURCE_DIR}/thirdpart/lib)
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /wd4996 /wd4355 /wd4244 /wd4985 /wd4267 /wd4290 /MP /MT")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /wd4996 /wd4355 /wd4244 /wd4267 /wd4290 /MP /MT")
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} /wd4996 /wd4355 /wd4244 /wd4985 /wd4267 /wd4290 /MP /W3 /MTd")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /wd4996 /wd4355 /wd4244 /wd4985 /wd4267 /wd4290 /MP /W3 /MTd")
else()
	include_directories(/usr/local/mysql/include)
    link_directories(/usr/local/mysql/lib)
    set(CMAKE_CXX_FLAGS "-g -Wall -Wfatal-errors -Wextra -Wfloat-equal -Wno-unused -std=c++0x -fPIC -pg -static")
endif(WIN32)

set(BIN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/bin/)
add_subdirectory(src)
