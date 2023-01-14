// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SoundEffectUseCase",
            targets: ["SoundEffectUseCase"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SoundEffectUseCase",
            dependencies: [],
            resources: [.copy("./Resources/correct.mp3"), .copy("./Resources/wrong.mp3")]
        )
//        .testTarget(
//            name: "ModulesTests",
//            dependencies: ["Modules"]),
    ]
)
