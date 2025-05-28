# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   CURRENT_INSTALLED_DIR     = ${VCPKG_ROOT_DIR}\installed\${TRIPLET}
#   DOWNLOADS                 = ${VCPKG_ROOT_DIR}\downloads
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#   VCPKG_TOOLCHAIN           = ON OFF
#   TRIPLET_SYSTEM_ARCH       = arm x86 x64
#   BUILD_ARCH                = "Win32" "x64" "ARM"
#   MSBUILD_PLATFORM          = "Win32"/"x64"/${TRIPLET_SYSTEM_ARCH}
#   DEBUG_CONFIG              = "Debug Static" "Debug Dll"
#   RELEASE_CONFIG            = "Release Static"" "Release DLL"
#   VCPKG_TARGET_IS_WINDOWS
#   VCPKG_TARGET_IS_UWP
#   VCPKG_TARGET_IS_LINUX
#   VCPKG_TARGET_IS_OSX
#   VCPKG_TARGET_IS_FREEBSD
#   VCPKG_TARGET_IS_ANDROID
#   VCPKG_TARGET_IS_MINGW
#   VCPKG_TARGET_EXECUTABLE_SUFFIX
#   VCPKG_TARGET_STATIC_LIBRARY_SUFFIX
#   VCPKG_TARGET_SHARED_LIBRARY_SUFFIX
#
# 	See additional helpful variables in /docs/maintainers/vcpkg_common_definitions.md
set(VCPKG_KEEP_ENV_VARS "ACCESS_TOKEN")

# Find Git binary path
find_program(GIT git REQUIRED)
if(NOT GIT)
    message(FATAL_ERROR "Git not found. Please install Git and add it to your PATH.")
else()
    get_filename_component(GIT_BIN_DIR "${GIT}" DIRECTORY)
    vcpkg_add_to_path("${GIT_BIN_DIR}")
endif()

# Find Rust Cargo binary path
if(WIN32)
    find_program(CARGO cargo HINTS "$ENV{USERPROFILE}/.cargo/bin")
else()
    find_program(CARGO cargo HINTS "$ENV{HOME}/.cargo/bin")
endif()
if(NOT CARGO)
    message(FATAL_ERROR "Cargo not found. Please install Rust and add it to your PATH.")
else()
    get_filename_component(CARGO_BIN_DIR "${CARGO}" DIRECTORY)
    vcpkg_add_to_path("${CARGO_BIN_DIR}")
endif()

# Also consider vcpkg_from_* functions if you can; the generated code here is for any web accessable
# source archive.
#  vcpkg_from_github
#  vcpkg_from_gitlab
#  vcpkg_from_bitbucket
#  vcpkg_from_sourceforge
vcpkg_download_distfile(ARCHIVE
    URLS "http://git.full-v.com/fullv/xtr/archive/v1.1.6+4.zip"
    FILENAME "xtr-1.1.6+4.zip"
    SHA512 79d8454612595271bddd69ae9f2ad8a9edffbfaa8c685121b1af84d3442c16dd44353fccc59ce1d0924d14581590665b884af6eee1abdaa5c626ce4420a493f9
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

# # Check if one or more features are a part of a package installation.
# # See /docs/maintainers/vcpkg_check_features.md for more details
vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES # <- Keyword FEATURES is required because INVERTED_FEATURES are being used
    win7   WITH_WIN7_COMPAT
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

# # Moves all .cmake files from /debug/share/xtr/ to /share/xtr/
# # See /docs/maintainers/ports/vcpkg-cmake-config/vcpkg_cmake_config_fixup.md for more details
# When you uncomment "vcpkg_cmake_config_fixup()", you need to add the following to "dependencies" vcpkg.json:
#{
#    "name": "vcpkg-cmake-config",
#    "host": true
#}
vcpkg_cmake_config_fixup()

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

# Uncomment the line below if necessary to install the license file for the port
# as a file named `copyright` to the directory `${CURRENT_PACKAGES_DIR}/share/${PORT}`
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")
