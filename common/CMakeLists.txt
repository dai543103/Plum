file(GLOB SRC_FILES_COMMON common/*)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
add_library(common ${SRC_FILES_COMMON})

set(LIBARY_COMMON common)

add_subdirectory(1_GatewayServer)