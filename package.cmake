set(CPACK_PACKAGE_VERSION 0.1.1)
set(CPACK_PACKAGE_RELEASE 1)
set(CPACK_PACKAGE_NAME "libmallocstat")
set(CPACK_PACKAGE_CONTACT "Michail Safronov <msaf1980@gmail.com>")
set(CPACK_PACKAGING_HOMEPAGE_URL "https://github.com/msaf1980/mallocstat")
set(CPACK_PACKAGING_INSTALL_PREFIX "/usr")
set(CPACK_PACKAGE_FILE_NAME
    "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CPACK_PACKAGE_RELEASE}.${CPACK_OS_RELEASE}.${CMAKE_SYSTEM_PROCESSOR}"
)
set(CPACK_ARCHIVE_COMPONENT_INSTALL ON)
set(CPACK_RPM_SPEC_MORE_DEFINE "%define _build_id_links none")
include(CPack)
