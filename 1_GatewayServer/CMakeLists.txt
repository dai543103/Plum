file(GLOB SRC_FILE *.h *.hpp *.cpp codeEngine/* netEngine/*)

add_executable(gateway ${SRC_FILE})
include_directories(${CMAKE_CURRENT_SOURCE_DIR} codeEngine netEngine)

if(WIN32)
	target_link_libraries(gateway ${LIBARY_COMMON} 
    debug mysqlclientd libprotobufd
    optimized mysqlclient libprotobuf)
else()
	target_link_libraries(gateway ${LIBARY_COMMON} mysqlclient protobuf pthread dl)
endif(WIN32)

install(TARGETS gateway DESTINATION ${BIN_DIR})
