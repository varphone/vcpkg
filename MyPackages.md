My Packages
===========

Setup Env
---------

```ps1
$env:VCPKG_OVERLAY_PORTS = "custom-ports"
$env:VCPKG_OVERLAY_TRIPLETS = "custom-triplets"
```

Install libwebp
---------------

```ps1
.\vcpkg.exe install libwebp[anim,nearlossless,libwebpmux]:x64-windows
.\vcpkg.exe install libwebp[anim,nearlossless,libwebpmux]:x64-windows-static
.\vcpkg.exe install libwebp[anim,nearlossless,libwebpmux]:x64-windows-static-md
.\vcpkg.exe install libwebp[anim,nearlossless,libwebpmux]:x86-windows
.\vcpkg.exe install libwebp[anim,nearlossless,libwebpmux]:x86-windows-static
```

Install FFmpeg
--------------

```ps1
.\vcpkg.exe install ffmpeg[avcodec,avdevice,avfilter,avformat,core,ffmpeg,lite,swresample,swscale,webp,zlib,amf,qsv,nvcodec,vpx]:x64-windows --clean-buildtrees-after-build
.\vcpkg.exe install ffmpeg[avcodec,avdevice,avfilter,avformat,core,ffmpeg,lite,swresample,swscale,webp,zlib,amf,qsv,nvcodec,vpx]:x64-windows-static --clean-buildtrees-after-build
.\vcpkg.exe install ffmpeg[avcodec,avdevice,avfilter,avformat,core,ffmpeg,lite,swresample,swscale,webp,zlib,amf,qsv,nvcodec,vpx]:x64-windows-static-md --clean-buildtrees-after-build
.\vcpkg.exe install ffmpeg[avcodec,avdevice,avfilter,avformat,core,ffmpeg,lite,swresample,swscale,webp,zlib,amf,qsv,nvcodec,vpx]:x86-windows --clean-buildtrees-after-build
.\vcpkg.exe install ffmpeg[avcodec,avdevice,avfilter,avformat,core,ffmpeg,lite,swresample,swscale,webp,zlib,amf,qsv,nvcodec,vpx]:x86-windows-static --clean-buildtrees-after-build
```

Install gRPC
------------

```ps1
.\vcpkg.exe install grpc[codegen]:x64-windows --clean-buildtrees-after-build
.\vcpkg.exe install grpc[codegen]:x64-windows-static --clean-buildtrees-after-build
.\vcpkg.exe install grpc[codegen]:x64-windows-static-md --clean-buildtrees-after-build
.\vcpkg.exe install grpc[codegen]:x86-windows --clean-buildtrees-after-build
.\vcpkg.exe install grpc[codegen]:x86-windows-static --clean-buildtrees-after-build
```

Install libzip
--------------

```ps1
.\vcpkg.exe install libzip:x64-windows
.\vcpkg.exe install libzip:x64-windows-static
.\vcpkg.exe install libzip:x64-windows-static-md
.\vcpkg.exe install libzip:x86-windows
.\vcpkg.exe install libzip:x86-windows-static
```

Install OpenSSL
---------------

```ps1
.\vcpkg.exe install openssl:x64-windows --clean-buildtrees-after-build
.\vcpkg.exe install openssl:x64-windows-static --clean-buildtrees-after-build
.\vcpkg.exe install openssl:x64-windows-static-md --clean-buildtrees-after-build
.\vcpkg.exe install openssl:x86-windows --clean-buildtrees-after-build
.\vcpkg.exe install openssl:x86-windows-static --clean-buildtrees-after-build
```

Install Qt5
-----------

```ps1
.\vcpkg.exe install qt5[3d,charts,datavis3d,declarative,graphicaleffects,imageformats,quickcontrols2,serialbus,serialport,svg,tools,translations,virtualkeyboard,websockets]:x64-windows
.\vcpkg.exe install qt5[3d,charts,datavis3d,declarative,graphicaleffects,imageformats,quickcontrols2,serialbus,serialport,svg,tools,translations,virtualkeyboard,websockets]:x64-windows-static
.\vcpkg.exe install qt5[3d,charts,datavis3d,declarative,graphicaleffects,imageformats,quickcontrols2,serialbus,serialport,svg,tools,translations,virtualkeyboard,websockets]:x86-windows
.\vcpkg.exe install qt5[3d,charts,datavis3d,declarative,graphicaleffects,imageformats,quickcontrols2,serialbus,serialport,svg,tools,translations,virtualkeyboard,websockets]:x86-windows-static
```

Install Qt6
-----------

```ps1
.\vcpkg.exe install qtbase[harfbuzz]:x64-windows qtcharts[qml]:x64-windows qtdatavis3d:x64-windows qtquick3d:x64-windows qttools:x64-windows qtvirtualkeyboard:x64-windows
.\vcpkg.exe install qtbase[harfbuzz]:x64-windows-static qtcharts[qml]:x64-windows-static qtdatavis3d:x64-windows-static qtquick3d:x64-windows-static qttools:x64-windows-static qtvirtualkeyboard:x64-windows-static
.\vcpkg.exe install qtbase[harfbuzz]:x64-windows-static-md qtcharts[qml]:x64-windows-static-md qtdatavis3d:x64-windows-static-md qtquick3d:x64-windows-static-md qttools:x64-windows-static-md qtvirtualkeyboard:x64-windows-static-md
.\vcpkg.exe install qtbase[harfbuzz]:x86-windows-static qtcharts[qml]:x86-windows-static qtdatavis3d:x86-windows-static qtquick3d:x86-windows-static qttools:x86-windows-static qtvirtualkeyboard:x86-windows-static
```

Install VTK
-----------

```ps1
.\vcpkg.exe install vtk[qt5]:x64-windows
.\vcpkg.exe install vtk[qt5]:x64-windows-static
.\vcpkg.exe install vtk[qt5]:x86-windows
.\vcpkg.exe install vtk[qt5]:x86-windows-static
```

Install PCL
-----------

```ps1
.\vcpkg.exe install pcl[opengl,visualization,vtk]:x64-windows
.\vcpkg.exe install pcl[opengl,visualization,vtk]:x64-windows-static
.\vcpkg.exe install pcl[opengl,visualization,vtk]:x86-windows
.\vcpkg.exe install pcl[opengl,visualization,vtk]:x86-windows-static
```

Install OpenCV
--------------

```ps1
.\vcpkg.exe install opencv[core,default-features,eigen,opengl,qt,world]:x64-windows
.\vcpkg.exe install opencv[core,default-features,eigen,opengl,qt,world]:x64-windows-static
.\vcpkg.exe install opencv[core,default-features,eigen,opengl,qt,world]:x64-windows-static-md
.\vcpkg.exe install opencv[core,default-features,eigen,opengl,qt,world]:x86-windows
.\vcpkg.exe install opencv[core,default-features,eigen,opengl,qt,world]:x86-windows-static
```
