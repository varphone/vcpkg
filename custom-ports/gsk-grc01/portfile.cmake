set(VCPKG_POLICY_ALLOW_DEBUG_SHARE enabled)
set(VCPKG_POLICY_ALLOW_OBSOLETE_MSVCRT enabled)
set(VCPKG_POLICY_DLLS_IN_STATIC_LIBRARY enabled)
set(VCPKG_POLICY_MISMATCHED_NUMBER_OF_BINARIES enabled)

vcpkg_download_distfile(ARCHIVE
    URLS "http://git.full-v.com/fullv/gsk-grc01/archive/v1.0.0.zip"
    FILENAME "gsk-grc01-1.0.0.zip"
    SHA512 f4be0000d7088472c0eac57a1fbb43f5a0458129e73b2358ab114108c7fd3607ea9db82463e68e20985d6c8403e780144a90162c77f828a5baf10a99f0bc9680
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
    # (Optional) A friendly name to use instead of the filename of the archive (e.g.: a version number or tag).
    # REF 1.0.0
    # (Optional) Read the docs for how to generate patches at:
    # https://github.com/Microsoft/vcpkg/blob/master/docs/examples/patching.md
    # PATCHES
    #   001_port_fixes.patch
    #   002_more_port_fixes.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    # OPTIONS
    #     -DCLI11_BUILD_EXAMPLES=OFF
    #     -DCLI11_BUILD_DOCS=OFF
    #     -DCLI11_BUILD_TESTS=OFF
)

vcpkg_cmake_install()

# vcpkg_cmake_config_fixup(PACKAGE_NAME "gsk-grc01" CONFIG_PATH "share/gsk-grc01")

# vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

# Handle usage
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
