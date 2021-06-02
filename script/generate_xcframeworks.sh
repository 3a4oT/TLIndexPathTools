#/bin/sh

FRAMEWORK_NAME="TLIndexPathTools"

IOS_SCHEME="${FRAMEWORK_NAME}"
CATALYST_NAME="${FRAMEWORK_NAME}-macCatalyst"
IOS_SIMULATOR_NAME="${FRAMEWORK_NAME}-iOS-Simulator"

HERE=$(pwd)

rm -r "${FRAMEWORK_NAME}.xcframework"

# iOS
xcodebuild archive \
-workspace "${FRAMEWORK_NAME}.xcworkspace" \
-scheme "${IOS_SCHEME}" \
-destination "generic/platform=iOS" \
-archivePath "${HERE}/archives/${IOS_SCHEME}" \
-configuration "Release" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Catalyst
xcodebuild archive \
-workspace "${FRAMEWORK_NAME}.xcworkspace" \
-scheme "${IOS_SCHEME}" \
-destination "generic/platform=macOS,variant=Mac Catalyst" \
-archivePath "${HERE}/archives/${CATALYST_NAME}" \
-configuration "Release" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# iOS Simulator
xcodebuild archive \
-workspace "${FRAMEWORK_NAME}.xcworkspace" \
-scheme "${IOS_SCHEME}" \
-destination "generic/platform=iOS Simulator" \
-archivePath "${HERE}/archives/${IOS_SIMULATOR_NAME}" \
-configuration "Release" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

#XCFramework

xcodebuild -create-xcframework \
-framework "${HERE}/archives/${IOS_SCHEME}.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
-debug-symbols "${HERE}/archives/${IOS_SCHEME}.xcarchive/dSYMs/${FRAMEWORK_NAME}.framework.dSYM" \
-framework "${HERE}/archives/${CATALYST_NAME}.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
-debug-symbols "${HERE}/archives/${CATALYST_NAME}.xcarchive/dSYMs/${FRAMEWORK_NAME}.framework.dSYM" \
-framework "${HERE}/archives/${IOS_SIMULATOR_NAME}.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
-debug-symbols "${HERE}/archives/${IOS_SIMULATOR_NAME}.xcarchive/dSYMs/${FRAMEWORK_NAME}.framework.dSYM" \
-output "${FRAMEWORK_NAME}.xcframework"
