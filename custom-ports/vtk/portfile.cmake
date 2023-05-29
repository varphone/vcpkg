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

# Also consider vcpkg_from_* functions if you can; the generated code here is for any web accessable
# source archive.
#  vcpkg_from_github
#  vcpkg_from_gitlab
#  vcpkg_from_bitbucket
#  vcpkg_from_sourceforge
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/Kitware/VTK/archive/refs/tags/v9.2.6.zip"
    FILENAME "VTK-9.2.6.zip"
    SHA512 91ec0939ef9652e68f7752c0bd9072ea9103becf2bee572e669f71a296fbe256707c7fedb01ecd38cf3ec3fe2478b7006e394a4bc66a6a2b3c6fcafdc04b0fc8
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
# vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
#   FEATURES # <- Keyword FEATURES is required because INVERTED_FEATURES are being used
#     tbb   WITH_TBB
#   INVERTED_FEATURES
#     tbb   ROCKSDB_IGNORE_PACKAGE_TBB
# )

# Replace common value to vtk value
list(TRANSFORM VTK_FEATURE_OPTIONS REPLACE "=ON" "=YES")
list(TRANSFORM VTK_FEATURE_OPTIONS REPLACE "=OFF" "=DONT_WANT")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
        -DVTK_BUILD_TESTING=OFF
        -DVTK_BUILD_EXAMPLES=OFF
        -DVTK_ENABLE_REMOTE_MODULES=OFF
        # VTK groups to enable
        -DVTK_GROUP_ENABLE_StandAlone=YES
        -DVTK_GROUP_ENABLE_Rendering=YES
        -DVTK_GROUP_ENABLE_Views=YES
        -DVTK_GROUP_ENABLE_Qt=YES
        -DVTK_MODULE_ENABLE_VTK_GUISupportQt=YES
        -DVTK_MODULE_ENABLE_VTK_GUISupportQtQuick=NO
        -DVTK_MODULE_ENABLE_VTK_GUISupportQtSQL=YES
        -DVTK_MODULE_ENABLE_VTK_RenderingQt=YES
        -DVTK_MODULE_ENABLE_VTK_ViewsQt=YES
        # Disable deps not in VCPKG
        -DVTK_USE_TK=OFF # TCL/TK currently not included in vcpkg
        # Select modules / groups to install
        # -DVTK_USE_EXTERNAL:BOOL=ON
        -DVTK_MODULE_USE_EXTERNAL_VTK_fmt:BOOL=ON
        -DVTK_MODULE_USE_EXTERNAL_VTK_gl2ps:BOOL=OFF # Not yet in VCPKG
        # -DVTK_DEBUG_MODULE_ALL=ON
        # -DVTK_DEBUG_MODULE=ON
)

vcpkg_cmake_install()

# # Moves all .cmake files from /debug/share/vtk/ to /share/vtk/
# # See /docs/maintainers/ports/vcpkg-cmake-config/vcpkg_cmake_config_fixup.md for more details
# When you uncomment "vcpkg_cmake_config_fixup()", you need to add the following to "dependencies" vcpkg.json:
#{
#    "name": "vcpkg-cmake-config",
#    "host": true
#}
# vcpkg_cmake_config_fixup()

# Uncomment the line below if necessary to install the license file for the port
# as a file named `copyright` to the directory `${CURRENT_PACKAGES_DIR}/share/${PORT}`
# vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

vcpkg_copy_pdbs()

# =============================================================================
# Fixup target files
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/vtk-9.2)

# =============================================================================
# Clean-up other directories

# Delete the debug binary TOOL_NAME that is not required
function(_vtk_remove_debug_tool TOOL_NAME)
    set(filename "${CURRENT_PACKAGES_DIR}/debug/bin/${TOOL_NAME}${VCPKG_TARGET_EXECUTABLE_SUFFIX}")
    if(EXISTS "${filename}")
        file(REMOVE "${filename}")
    endif()
    set(filename "${CURRENT_PACKAGES_DIR}/debug/bin/${TOOL_NAME}d${VCPKG_TARGET_EXECUTABLE_SUFFIX}")
    if(EXISTS "${filename}")
        file(REMOVE "${filename}")
    endif()
    if (NOT VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL debug)
        # we also have to bend the lines referencing the tools in VTKTargets-debug.cmake
        # to make them point to the release version of the tools
        file(READ "${CURRENT_PACKAGES_DIR}/share/vtk/VTK-targets-debug.cmake" VTK_TARGETS_CONTENT_DEBUG)
        string(REPLACE "debug/bin/${TOOL_NAME}" "tools/vtk/${TOOL_NAME}" VTK_TARGETS_CONTENT_DEBUG "${VTK_TARGETS_CONTENT_DEBUG}")
        string(REPLACE "tools/vtk/${TOOL_NAME}d" "tools/vtk/${TOOL_NAME}" VTK_TARGETS_CONTENT_DEBUG "${VTK_TARGETS_CONTENT_DEBUG}")
        file(WRITE "${CURRENT_PACKAGES_DIR}/share/vtk/VTK-targets-debug.cmake" "${VTK_TARGETS_CONTENT_DEBUG}")
    endif()
endfunction()

# Move the release binary TOOL_NAME from bin to tools
function(_vtk_move_release_tool TOOL_NAME)
    set(old_filename "${CURRENT_PACKAGES_DIR}/bin/${TOOL_NAME}${VCPKG_TARGET_EXECUTABLE_SUFFIX}")
    if(EXISTS "${old_filename}")
        file(INSTALL "${old_filename}" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/vtk" USE_SOURCE_PERMISSIONS)
        file(REMOVE "${old_filename}")
    endif()

    if (NOT VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL release)
        # we also have to bend the lines referencing the tools in VTKTargets-release.cmake
        # to make them point to the tool folder
        file(READ "${CURRENT_PACKAGES_DIR}/share/vtk/VTK-targets-release.cmake" VTK_TARGETS_CONTENT_RELEASE)
        string(REPLACE "bin/${TOOL_NAME}" "tools/vtk/${TOOL_NAME}" VTK_TARGETS_CONTENT_RELEASE "${VTK_TARGETS_CONTENT_RELEASE}")
        file(WRITE "${CURRENT_PACKAGES_DIR}/share/vtk/VTK-targets-release.cmake" "${VTK_TARGETS_CONTENT_RELEASE}")
    endif()
endfunction()

set(VTK_SHORT_VERSION 9.2)
set(VTK_TOOLS
    vtkEncodeString-${VTK_SHORT_VERSION}
    vtkHashSource-${VTK_SHORT_VERSION}
    vtkWrapTclInit-${VTK_SHORT_VERSION}
    vtkWrapTcl-${VTK_SHORT_VERSION}
    vtkWrapPythonInit-${VTK_SHORT_VERSION}
    vtkWrapPython-${VTK_SHORT_VERSION}
    vtkWrapJava-${VTK_SHORT_VERSION}
    vtkWrapHierarchy-${VTK_SHORT_VERSION}
    vtkParseJava-${VTK_SHORT_VERSION}
    vtkParseOGLExt-${VTK_SHORT_VERSION}
    vtkProbeOpenGLVersion-${VTK_SHORT_VERSION}
    vtkTestOpenGLVersion-${VTK_SHORT_VERSION}
    vtkpython
    pvtkpython
)
# TODO: Replace with vcpkg_copy_tools if known which tools are built with which feature
# or add and option to vcpkg_copy_tools which does not require the tool to be present
foreach(TOOL_NAME IN LISTS VTK_TOOLS)
    _vtk_remove_debug_tool("${TOOL_NAME}")
    _vtk_move_release_tool("${TOOL_NAME}")
endforeach()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin"
                        "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_copy_tool_dependencies("${CURRENT_PACKAGES_DIR}/tools/vtk")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(RENAME "${CURRENT_PACKAGES_DIR}/share/licenses" "${CURRENT_PACKAGES_DIR}/share/${PORT}/licenses")

# =============================================================================
# Usage
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)

# Handle copyright
file(INSTALL "${SOURCE_PATH}/Copyright.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME "copyright")
