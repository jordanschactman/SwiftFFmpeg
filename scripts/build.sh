#!/bin/bash

FFMPEG_VERSION=4.3.1
FFMPEG_SOURCE_DIR=FFmpeg-n$FFMPEG_VERSION
FFMPEG_LIBS="libavcodec libavdevice libavfilter libavformat libavutil libpostproc libswresample libswscale"

HOST_ARCH=$(uname -m)
HOST_OS=$(uname -s)

PREFIXES=("`pwd`/output-x86_64")
ARCHES=("x86_64")

if [[ "$HOST_ARCH" == "arm64" ]]; then
  PREFIXES+=("`pwd`/output-arm64")
  ARCHES+=("arm64")
fi

if [ ! -d $FFMPEG_SOURCE_DIR ]; then
  echo "Start downloading FFmpeg..."
  curl -LJO https://codeload.github.com/FFmpeg/FFmpeg/tar.gz/n$FFMPEG_VERSION || exit 1
  tar -zxvf FFmpeg-n$FFMPEG_VERSION.tar.gz || exit 1
  rm -f FFmpeg-n$FFMPEG_VERSION.tar.gz
fi

echo "Start compiling FFmpeg..."

for prefix in ${PREFIXES[@]}; do
  rm -rf $prefix
done

cd $FFMPEG_SOURCE_DIR

for i in ${!PREFIXES[@]}; do

  if [[ "${ARCHES[$i]}" != "$HOST_ARCH" ]]; then

    ./configure --prefix=${PREFIXES[$i]} \
      --enable-gpl \
      --enable-version3 \
      --disable-programs \
      --disable-doc \
      --enable-cross-compile \
      --arch=${ARCHES[$i]} \
      --extra-cflags="-fno-stack-check -target ${ARCHES[$i]}-apple-macos10.10" \
      --extra-ldflags="-target ${ARCHES[$i]}-apple-macos10.10" \
      --disable-debug || exit 1

  else

    if [[ "$HOST_OS" == "Darwin" ]]; then

      ./configure --prefix=${PREFIXES[$i]} \
        --enable-gpl \
        --enable-version3 \
        --disable-programs \
        --disable-doc \
        --arch=${ARCHES[$i]} \
        --extra-cflags="-fno-stack-check -target ${ARCHES[$i]}-apple-macos10.10" \
        --extra-ldflags="-target ${ARCHES[$i]}-apple-macos10.10" \
        --disable-debug || exit 1

    else

      ./configure --prefix=${PREFIXES[$i]} \
        --enable-gpl
        --enable-version3 \
        --disable-programs \
        --disable-doc \
        --arch=${ARCHES[$i]} \
        --extra-cflags="-fno-stack-check" \
        --disable-debug || exit 1

    fi

  fi

  make clean
  make -j8 install || exit 1

done

cd ..

function build_framework() {

  local LIB_NAME=$1

  local LIB_XCFRAMEWORK=xcframework/$LIB_NAME.xcframework
  local LIB_FRAMEWORK=framework/$LIB_NAME.framework

  # build framework

  rm -rf $LIB_FRAMEWORK

  mkdir -p $LIB_FRAMEWORK/Headers
  cp -R ${PREFIXES[0]}/include/$LIB_NAME/ $LIB_FRAMEWORK/Headers

  if [ ${#PREFIXES[@]} -gt 1 ]; then

    local LIBS=()

    for prefix in ${PREFIXES[@]}; do
      LIBS+=("$prefix/lib/$LIB_NAME.a")
    done

    lipo -create "${LIBS[@]}" -output $LIB_FRAMEWORK/$LIB_NAME

  else
    cp ${PREFIXES[0]}/lib/$LIB_NAME.a $LIB_FRAMEWORK/$LIB_NAME
  fi

  cat > $LIB_FRAMEWORK/Info.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDevelopmentRegion</key>
  <string>en</string>
  <key>CFBundleExecutable</key>
  <string>$LIB_NAME</string>
  <key>CFBundleIdentifier</key>
  <string>org.ffmpeg.$LIB_NAME</string>
  <key>CFBundleInfoDictionaryVersion</key>
  <string>6.0</string>
  <key>CFBundleName</key>
  <string>$LIB_NAME</string>
  <key>CFBundlePackageType</key>
  <string>FMWK</string>
  <key>CFBundleShortVersionString</key>
  <string>$FFMPEG_VERSION</string>
  <key>CFBundleVersion</key>
  <string>$FFMPEG_VERSION</string>
  <key>CFBundleSignature</key>
  <string>????</string>
  <key>NSPrincipalClass</key>
  <string></string>
</dict>
</plist>
EOF

  # build xcframework

  rm -rf $LIB_XCFRAMEWORK

  if [[ "$HOST_ARCH" == "arm64" ]]; then

    mkdir -p $LIB_XCFRAMEWORK/macos-universal
    cp -R $LIB_FRAMEWORK $LIB_XCFRAMEWORK/macos-universal

    cat > $LIB_XCFRAMEWORK/Info.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>AvailableLibraries</key>
  <array>
    <dict>
      <key>LibraryIdentifier</key>
      <string>macos-universal</string>
      <key>LibraryPath</key>
      <string>$LIB_NAME.framework</string>
      <key>SupportedArchitectures</key>
      <array>
        <string>x86_64</string>
        <string>arm64</string>
      </array>
      <key>SupportedPlatform</key>
      <string>macos</string>
    </dict>
  </array>
  <key>CFBundlePackageType</key>
  <string>XFWK</string>
  <key>XCFrameworkFormatVersion</key>
  <string>1.0</string>
</dict>
</plist>
EOF

else

  mkdir -p $LIB_XCFRAMEWORK/macos-x86_64
  cp -R $LIB_FRAMEWORK $LIB_XCFRAMEWORK/macos-x86_64

  cat > $LIB_XCFRAMEWORK/Info.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>AvailableLibraries</key>
  <array>
    <dict>
      <key>LibraryIdentifier</key>
      <string>macos-x86_64</string>
      <key>LibraryPath</key>
      <string>$LIB_NAME.framework</string>
      <key>SupportedArchitectures</key>
      <array>
        <string>x86_64</string>
      </array>
      <key>SupportedPlatform</key>
      <string>macos</string>
    </dict>
  </array>
  <key>CFBundlePackageType</key>
  <string>XFWK</string>
  <key>XCFrameworkFormatVersion</key>
  <string>1.0</string>
</dict>
</plist>
EOF

  fi

}

for LIB in $FFMPEG_LIBS; do
  build_framework $LIB || exit 1
done

echo "The compilation of FFmpeg is completed."
