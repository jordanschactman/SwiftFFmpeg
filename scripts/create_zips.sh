#!/bin/bash

FFMPEG_LIBS="libavcodec libavdevice libavfilter libavformat libavutil libpostproc libswresample libswscale"

cd "xcframework"

for LIB in $FFMPEG_LIBS; do
	zip -r "../$LIB.zip" "$LIB.xcframework" > /dev/null || exit 1
	checksum=$(swift package compute-checksum "../$LIB.zip")
	echo "$LIB: $checksum"
done

cd ..