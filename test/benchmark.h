#ifndef _BENCHMARKS_H_
#define _BENCHMARKS_H_

#include <time.h>

static inline unsigned long long clock_ns()
{
	struct timespec tm;
	clock_gettime(CLOCK_MONOTONIC, &tm);
	return 1000000000uLL * tm.tv_sec + tm.tv_nsec;
}

#endif /* _BENCHMARKS_H_ */
