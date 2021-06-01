set ( TEST_LIBRARIES ${PROJECT} dl )
set( BENCH_LIBRARIES )

include_directories( "../include" )

# Build tests
file( GLOB testFiles *_test.cpp *_test.c )
foreach( testFile ${testFiles} )
	#string(REGEX REPLACE "^(.*)\/test\/(.*)_test\.(c.*)$" "\\1/src/\\2.\\3" srcFile "${testFile}")
	#list( APPEND TEST_FILES "${srcFile}" )
	file(RELATIVE_PATH test_file ${CMAKE_CURRENT_SOURCE_DIR} ${testFile})
	string(REGEX REPLACE "^([0-9a-zA-Z_\\-]+)_test\.c.*$" "\\1" test "${test_file}")
	add_executable( "test_${test}" "${testFile}" )
	target_link_libraries( "test_${test}" mallocstat dl )
	add_test(
		NAME "test_${test}"
		COMMAND "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/test_${test}"
	)
endforeach(testFile)

add_executable( bench_malloc malloc_bench.c )
target_link_libraries( bench_malloc mallocstat dl )

add_executable( bench_malloc_sys malloc_bench.c )
