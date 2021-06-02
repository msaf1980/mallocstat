set ( MALLOCSTAT_TARGET mallocstat )

set ( MALLOCSTAT_SOURCES )
set ( MALLOCSTAT_LIBRARIES )
set ( MALLOCSTAT_INCLUDES )

# Scan dir for standart source files
aux_source_directory( ${CMAKE_CURRENT_SOURCE_DIR} MALLOCSTAT_SOURCES )

# Add executable target
add_library( "${MALLOCSTAT_TARGET}" SHARED ${MALLOCSTAT_SOURCES} )
set_target_properties("${MALLOCSTAT_TARGET}" PROPERTIES PUBLIC_HEADER "../include/mallocstat.h")
target_include_directories( "${MALLOCSTAT_TARGET}" PRIVATE ${MALLOCSTAT_INCLUDES} )
target_link_libraries( "${MALLOCSTAT_TARGET}" ${MALLOCSTAT_LIBRARIES} )
install( TARGETS "${MALLOCSTAT_TARGET}" )
