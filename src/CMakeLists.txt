set ( MAIN_TARGET ${PROJECT} )

set ( MAIN_SOURCES )
set ( MAIN_LIBRARIES )
set ( MAIN_INCLUDES )

#list( APPEND MAIN_INCLUDES ${CXXOPTS_INCLUDE_DIR} )
#list( APPEND MAIN_INCLUDES ${CONAN_INCLUDE_DIRS_FMT} )
#list( APPEND MAIN_LIBRARIES fmt )

# Scan dir for standart source files
aux_source_directory( ${CMAKE_CURRENT_SOURCE_DIR} MAIN_SOURCES )

# Add executable target
add_library( "${MAIN_TARGET}" SHARED ${MAIN_SOURCES} )
target_include_directories( "${MAIN_TARGET}" PRIVATE ${MAIN_INCLUDES} )
target_link_libraries( "${MAIN_TARGET}" ${MAIN_LIBRARIES} )
install( TARGETS "${MAIN_TARGET}" DESTINATION "${CMAKE_INSTALL_BINDIR}" )
