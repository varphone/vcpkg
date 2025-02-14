vcpkg_download_distfile(ARCHIVE
    URLS "http://git.full-v.com/fullv/libfvbase/archive/v1.0.1.zip"
    FILENAME "fvbase-1.0.1.zip"
    SHA512 1c9e78bade4646066cb818818f372ec4828aae2fe21ab141752239e1d4b1416b730ff8dec07bad697ec81d13dbaccfac3aebde2aa062c14e81434734f6f8d445
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

vcpkg_cmake_config_fixup(PACKAGE_NAME "fvbase" CONFIG_PATH "share/cmake/fvbase")

vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
