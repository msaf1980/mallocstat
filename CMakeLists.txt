cmake_minimum_required( VERSION 3.14 )

# Options can be turned on and off by providing cmake with a -DOPTIONNAME=ON (or OFF) argument.
# For example, to turn off benchmarks, and use sanitize flags in a DEBUG build:
#    cmake .. -DCMAKE_BUILD_TYPE=DEBUG -DBENCH=OFF -DSANITIZE=ON

# Add test files with filenames <NAME>_test.cpp or <NAME>_test.c into test dir
# Add bench files with filenames <NAME>_bench.cpp or <NAME>_bench.c into test dir

# Override install prefix with CMAKE_INSTALL_PREFIX

# Put tests and benchmarks into DIR_TESTS dirs
# Tests by glob *_test.cpp *_test.c
# Benchmarks by glob *_bench.cpp *_bench.c

include(${CMAKE_SOURCE_DIR}/settings.cmake)

set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib )
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib )
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin )

# Include cmake prescript from cmake dir
file(GLOB cmakeFiles ${DIR_PRESCRIPT}/*.cmake)
foreach(cmakeFile ${cmakeFiles})
	message("INCLUDE ${cmakeFile}")
	INCLUDE(${cmakeFile})
endforeach(cmakeFile)

project( ${PROJECT} )

file(GLOB cmakeFiles ${DIR_SCRIPT}/*.cmake)
foreach(cmakeFile ${cmakeFiles})
	message("INCLUDE ${cmakeFile}")
	INCLUDE(${cmakeFile})
endforeach(cmakeFile)

if(BENCH)
	set(TEST ON)
endif()

if ( DEFINED DIR_INCLUDES )
	# Includes in separate directory, also include dependecies headers
	include_directories( ${DIR_INCLUDES} )
endif()

if(DEFINED ENV{DEVENV})
	set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
endif()

foreach ( dir IN LISTS DIR_SUB )
	message("ADD ${dir}")
	add_subdirectory( ${dir} )
endforeach()

if (TEST)
	#enable_testing()
	include (CTest)
	if ( DEFINED DIR_TESTS )
		#set enable testing
		foreach ( dir IN LISTS DIR_TESTS )
			message("ADD TEST ${dir}")
			add_subdirectory( ${dir} )
		endforeach()
	endif()
endif() # END TEST

include(${CMAKE_SOURCE_DIR}/options_print.cmake)
