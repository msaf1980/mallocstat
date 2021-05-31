#include <mallocstat.h>

#define CTEST_MAIN

#include "ctest.h"

CTEST(malloc, test_simple) {
    alloc_statistic stat, check;
    void *p;

    check.count = 0;
    check.bytes = 0;
    check.failed = 0;
    get_alloc_stat(&stat); // reset statistic

   
    p = malloc(1024);
    if (p) {
        check.count++;
        check.bytes += 1024;
    } else {
        check.failed++;
    }

    get_alloc_stat(&stat);
    if (p) {
        ASSERT_EQUAL_U(check.count, stat.count);
        ASSERT_EQUAL_U(check.bytes, stat.bytes);
    } else {
        ASSERT_EQUAL_U(check.failed, stat.failed);
    }


    check.count = 0;
    check.bytes = 0;
    check.failed = 0;

    p = malloc(512);
    if (p) {
        check.count++;
        check.bytes += 512;
    } else {
        check.failed++;
    }

    p = malloc(128);
    if (p) {
        check.count++;
        check.bytes += 128;
    } else {
        check.failed++;
    }

    get_alloc_stat(&stat);
    if (p) {
        ASSERT_EQUAL_U(check.count, stat.count);
        ASSERT_EQUAL_U(check.bytes, stat.bytes);
    } else {
        ASSERT_EQUAL_U(check.failed, stat.failed);
    }

    /* check for reset counters at previous get_alloc_stat */
    get_alloc_stat(&stat);
    ASSERT_EQUAL_U(0, stat.count);
    ASSERT_EQUAL_U(0, stat.bytes);
    ASSERT_EQUAL_U(0, stat.failed);
}


int main(int argc, const char *argv[])
{
    return ctest_main(argc, argv);
}
