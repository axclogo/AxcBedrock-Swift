// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AxcBedrock",
    platforms: [
        .iOS(.v10),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "AxcBedrock",
            targets: ["AxcBedrockCore"]
        ),
        .library(
            name: "AxcBedrockCore",
            targets: ["AxcBedrockCore"]
        ),
    ],
    targets: [
        .target(
            name: "AxcBedrockCore",
            path: "AxcBedrock/Classes",
            sources: [
                "Core",
                "Enum",
                "Utils",
                "Wrapper",
                "Extension/SwiftLib",
                "Extension/Foundation",
                "Extension/CoreFoundation",
                "Extension/CoreGraphics",
                "Extension/CoreImage",
                "Extension/CoreLocation",
                "Extension/CoreMedia",
                "Extension/CoreText",
                "Extension/CoreVideo",
                "Extension/QuartzCore",
                "Extension/CrossPlatform",
                "Extension/UIKit",
                "Extension/AppKit",
                "Extension/AVFoundation",
                "Extension/LocalAuthentication",
                "Extension/MapKit",
                "Extension/WebKit",
            ]
        ),
        .testTarget(
            name: "AxcBedrockTests",
            dependencies: ["AxcBedrockCore"],
            path: "Tests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
