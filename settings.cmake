option( TEST      "Build tests" ON )
option( BENCH     "Build benchmarks" OFF )
option( ASAN      "Adds sanitize flags" OFF )
option( TSAN      "Adds thread sanitize flags" OFF )
option( PROFILE   "Enable profiling with gperftools" OFF )
option( DEBUGINFO "Add debug info" ON )

set( PROJECT mallocstat )

set( DIR_SUB src )
set( DIR_INCLUDES include )
set( DIR_TESTS test )

set( DIR_SCRIPT cmake )
set( DIR_PRESCRIPT cmake_pre )
