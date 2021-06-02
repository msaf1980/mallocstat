string(REGEX MATCH "Clang" CMAKE_COMPILER_IS_CLANG "${CMAKE_C_COMPILER_ID}")
string(REGEX MATCH "GNU" CMAKE_COMPILER_IS_GNU "${CMAKE_C_COMPILER_ID}")
string(REGEX MATCH "IAR" CMAKE_COMPILER_IS_IAR "${CMAKE_C_COMPILER_ID}")
string(REGEX MATCH "MSVC" CMAKE_COMPILER_IS_MSVC "${CMAKE_C_COMPILER_ID}")

function(append_flag FLAGS_VAR FLAG_VAR CHECK_VAR)
	string(FIND FLAGS_VAR "${CHECK_VAR}" res)
	if(res EQUAL -1)
		set(${FLAGS_VAR} "${${FLAGS_VAR}} ${FLAG_VAR}" PARENT_SCOPE)
	endif()
endfunction()

if(CMAKE_COMPILER_IS_GNU)
    # some warnings we want are not available with old GCC versions
    # note: starting with CMake 2.8 we could use CMAKE_C_COMPILER_VERSION
    execute_process(COMMAND ${CMAKE_C_COMPILER} -dumpversion
                    OUTPUT_VARIABLE GCC_VERSION)
    if (GCC_VERSION VERSION_GREATER 4.5 OR GCC_VERSION VERSION_EQUAL 4.5)
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wlogical-op")
    endif()
    if (GCC_VERSION VERSION_GREATER 4.8 OR GCC_VERSION VERSION_EQUAL 4.8)
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wshadow")
    endif()
endif(CMAKE_COMPILER_IS_GNU)

if(CMAKE_COMPILER_IS_GNU OR CMAKE_COMPILER_IS_CLANG)
	#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wpedantic -Wconversion -Wold-style-cast")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -W -Wpedantic -Wconversion -Wold-style-cast -Wwrite-strings")
	#set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Wpedantic -Wconversion")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -W -Wpedantic -Wconversion -Wdeclaration-after-statement -Wwrite-strings")

	# None Debug Release Coverage ASan ASanDbg TSan TSanDbg"
	if(CMAKE_BUILD_TYPE STREQUAL "Coverage")
		if(CMAKE_COMPILER_IS_GNU OR CMAKE_COMPILER_IS_CLANG)
			set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} --coverage")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --coverage")
			set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --coverage")
		endif(CMAKE_COMPILER_IS_GNU OR CMAKE_COMPILER_IS_CLANG)
	endif(CMAKE_BUILD_TYPE STREQUAL "Coverage")

	if(CMAKE_BUILD_TYPE STREQUAL "ASan")
		set(DEBUGINFO ON)
		set(ASAN ON)
	endif(CMAKE_BUILD_TYPE STREQUAL "ASan")

	if(CMAKE_BUILD_TYPE STREQUAL "ASanDbg")
		set(ASAN ON)
		set(DEBUGINFO ON)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_DEBUG} -fno-omit-frame-pointer -fno-optimize-sibling-calls")
		set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_DEBUG} -fno-omit-frame-pointer -fno-optimize-sibling-calls")
		append_flag(CMAKE_C_FLAGS "-O0" "-O")
		append_flag(CMAKE_CXX_FLAGS "-O0" "-O")
		add_definitions(-DDEBUG)
	endif(CMAKE_BUILD_TYPE STREQUAL "ASanDbg")

	if(CMAKE_BUILD_TYPE STREQUAL "TSan")
		set(DEBUGINFO ON)
		set(TSAN ON)
	endif(CMAKE_BUILD_TYPE STREQUAL "TSan")

	if(CMAKE_BUILD_TYPE STREQUAL "TSanDbg")
		set(TSAN ON)
		set(DEBUGINFO ON)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_DEBUG} -fno-omit-frame-pointer -fno-optimize-sibling-calls")
		set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_DEBUG} -fno-omit-frame-pointer -fno-optimize-sibling-calls")
		append_flag(CMAKE_C_FLAGS "-O0" "-O")
		append_flag(CMAKE_CXX_FLAGS "-O0" "-O")
		add_definitions(-DDEBUG)
	endif(CMAKE_BUILD_TYPE STREQUAL "TSanDbg")

	if(CMAKE_BUILD_TYPE STREQUAL "Debug")
		set(DEBUGINFO OFF)
		append_flag(CMAKE_C_FLAGS_DEBUG "-O0" "-O")
		append_flag(CMAKE_CXX_FLAGS_DEBUG "-O0" "-O")
		add_definitions(-DDEBUG)
	endif(CMAKE_BUILD_TYPE STREQUAL "Debug")

	# if(CMAKE_BUILD_TYPE STREQUAL "Release")
	# endif(CMAKE_BUILD_TYPE STREQUAL "Release")

	if(ASAN)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address -fsanitize=undefined -fno-common")
		set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=address -fsanitize=undefined -fno-common")
		set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -lasan -lubsan")
		set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lasan -lubsan")
	elseif(TSAN)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=thread")
		set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=thread")
		#list( APPEND LIBRARIES tsan )
		set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -ltsan")
		set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -ltsan")	
	endif()

	if(DEBUGINFO)
		append_flag(CMAKE_C_FLAGS "-g" "-g")
		append_flag(CMAKE_CXX_FLAGS "-g" "-g")
	endif()

	if(PROFILE)
		set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lprofiler")
	endif()

endif(CMAKE_COMPILER_IS_GNU OR CMAKE_COMPILER_IS_CLANG)
