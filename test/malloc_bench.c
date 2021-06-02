#include <stdio.h>

#include <mallocstat.h>

#define CTEST_MAIN

#include "ctest.h"
#include "benchmark.h"

int main(int argc, const char *argv[])
{
    size_t count = 10000;
    size_t i;
    double duration;

    unsigned long long start = clock_ns();
    for (i = 0; i < count; i++) {
        void *p = malloc(4096);
        free(p);
    }
    duration = (double) (clock_ns() - start) / count;

#ifdef SYS_MALLOC
    printf("sys ");
#else
    printf("mallocstat ");
#endif
    printf("malloc/free %.2f ns\n", duration);
}
