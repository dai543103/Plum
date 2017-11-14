file(GLOB SRC_FILE src/*)

add_executable(gateway ${SRC_FILE})

if(WIN32)
	target_link_libraries(gateway ${LIBARY_COMMON} 
    debug mysqlclientd libprotobufd
    optimized mysqlclient libprotobuf)
else()
	target_link_libraries(gateway ${LIBARY_COMMON} mysqlclient protobuf pthread dl)
endif(WIN32)

install(TARGETS gateway DESTINATION ${BIN_DIR})
