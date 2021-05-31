#include <mallocstat.h>

#define _GNU_SOURCE

#include <dlfcn.h>


static void* (*malloc_fptr)(size_t size) = NULL;

static size_t alloc_bytes = 0;
static size_t alloc_count = 0;
static size_t alloc_failed = 0;

void *malloc(size_t size) {
    if (malloc_fptr == NULL) {
        malloc_fptr = (void *(*)(size_t))dlsym(RTLD_NEXT, "malloc");
    }
    void *p = (*malloc_fptr)(size); // Calling original malloc

    if (p) {
        __sync_fetch_and_add(&(alloc_count), 1);
        __sync_fetch_and_add(&(alloc_bytes), size);
    } else {
        __sync_fetch_and_add(&(alloc_failed), 1);
    }

    return p;
}

void get_alloc_stat(alloc_statistic *stat) {
    stat->bytes = __sync_fetch_and_and(&(alloc_bytes), 0);
    stat->count = __sync_fetch_and_and(&(alloc_count), 0);
    stat->failed = __sync_fetch_and_and(&(alloc_failed), 0);
}