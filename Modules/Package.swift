// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "SoundEffectUseCase", targets: ["SoundEffectUseCase"]),
        .library(name: "OrientationAdaptiveViews", targets: ["OrientationAdaptiveViews"]),
        .library(name: "TapGame", targets: ["TapGame"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SoundEffectUseCase",
            dependencies: [],
            resources: [.copy("./Resources/correct.mp3"), .copy("./Resources/wrong.mp3")]
        ),
        .target(name: "OrientationAdaptiveViews", dependencies: []),
        .target(name: "TapGame", dependencies: ["OrientationAdaptiveViews"])
    ]
)
