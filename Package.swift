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
            exclude: [
                "Extension/UIKit",
                "Extension/AppKit",
                "Extension/AVFoundation",
                "Extension/LocalAuthentication",
                "Extension/MapKit",
                "Extension/WebKit",
                "Extension/CoreImage",
                "Extension/CoreGraphics/AxcCGImageEx.swift",
                "Extension/CoreGraphics/Linkage/Unified/AxcUnifiedImage+CoreGraphic.swift",
                "Extension/CrossPlatform/AppKitAndUIKit/Typealias/AxcBedrockBezierPathEx.swift",
                "Extension/CrossPlatform/AppKitAndUIKit/Typealias/AxcBedrockImageEx.swift",
                "Extension/CrossPlatform/SwiftLib/AxcStringEx+Platform.swift",
            ],
            sources: [
                "Core",
                "Enum",
                "Utils",
                "Wrapper",
                "Extension/SwiftLib",
                "Extension/Foundation",
                "Extension/CoreFoundation",
                "Extension/CoreGraphics",
                "Extension/CoreLocation",
                "Extension/CoreMedia",
                "Extension/CoreText",
                "Extension/CoreVideo",
                "Extension/QuartzCore",
                "Extension/CrossPlatform",
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
