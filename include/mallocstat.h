#ifndef __MALLOCSTAT_H__
#define __MALLOCSTAT_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stddef.h>

typedef struct alloc_statistic_ {
    size_t bytes;
    size_t count;
    size_t failed;
} alloc_statistic;

void get_alloc_stat(alloc_statistic *stat);

#ifdef __cplusplus
}
#endif

#endif // __MALLOCSTAT_H__