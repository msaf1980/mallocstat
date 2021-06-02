#include <mallocstat.h>

#define CATCH_CONFIG_MAIN

#include "catch.hpp"

TEST_CASE( "simple", "[malloc]" ) {
    alloc_statistic stat, check;
    char *p;

    check.count = 0;
    check.bytes = 0;
    check.failed = 0;
    get_alloc_stat(&stat); // reset statistic
   
    p = new char[1024];
    if (p) {
        check.count++;
        check.bytes += 1024;
    } else {
        check.failed++;
    }
    delete[] p;

    get_alloc_stat(&stat);
    if (p) {
        REQUIRE(check.count == stat.count);
        REQUIRE(check.bytes == stat.bytes);
    } else {
        REQUIRE(check.failed == stat.failed);
    }

    check.count = 0;
    check.bytes = 0;
    check.failed = 0;

    p = new char[512];
    if (p) {
        check.count++;
        check.bytes += 512;
    } else {
        check.failed++;
    }
    delete[] p;

    p = static_cast<char *>(malloc(128));
    if (p) {
        check.count++;
        check.bytes += 128;
    } else {
        check.failed++;
    }
    free(p);

    get_alloc_stat(&stat);
    if (p) {
        REQUIRE(check.count == stat.count);
        REQUIRE(check.bytes == stat.bytes);
    } else {
        REQUIRE(check.failed == stat.failed);
    }

    /* check for reset counters at previous get_alloc_stat */
    get_alloc_stat(&stat);
    REQUIRE(0 == stat.count);
    REQUIRE(0 == stat.bytes);
    REQUIRE(0 == stat.failed);
}
