# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/array
    REF boost-${VERSION}
    SHA512 6532b0b32141bb652bbc9b5917164caf00f28c2a1e9ee60f3e6334d5063554fbc9a9acb9a0a8032841b48a33f5b285fefc2870118d07b1e13080b40156b30e4b
    HEAD_REF master
)

set(FEATURE_OPTIONS "")
boost_configure_and_install(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS ${FEATURE_OPTIONS}
)
