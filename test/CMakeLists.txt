set(TEST_LIBRARIES ${PROJECT} dl)
set(BENCH_LIBRARIES)

include_directories("../include")

add_executable("test_malloc" "malloc_test.c")
target_link_libraries("test_malloc" mallocstat dl)
add_test(NAME "test_malloc"
         COMMAND "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/test_malloc")

if(MALLOCSTAT_TEST_CPP)
    add_executable("test_malloc_cpp" "malloc_test.cpp")
    target_link_libraries("test_malloc_cpp" mallocstat dl)
    add_test(NAME "test_malloc_cpp"
             COMMAND "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/test_malloc_cpp")
endif()

add_executable(bench_malloc malloc_bench.c)
target_link_libraries(bench_malloc mallocstat dl)

add_executable(bench_malloc_sys malloc_bench.c)
target_compile_definitions(bench_malloc_sys PRIVATE -DSYS_MALLOC)
