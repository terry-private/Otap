// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

enum Modules: String, CaseIterable, Hashable {
    case Components
    case Core
    case CoreImpl
    case Data
    case Extensions
    case FeatureSelectLevel
    case FeatureSelectQuiz
    case FeatureVoiceQuiz
    case Repository
    case Utility
    case ViewFactoryImpl
    
    var dependencies: [Self] {
        switch self {
        case .Components: return [
            .Extensions
        ]
            
        case .Core: return [
            .Extensions
        ]
        case .CoreImpl: return [
            .Core,
            .Extensions
        ]
            
        case .Data: return [
            .Core
        ]
            
        case .Extensions: return []
            
        case .FeatureSelectLevel: return [
            .Core,
            .Components,
            .Extensions,
            .Repository,
        ]
        case .FeatureSelectQuiz: return [
            .Core,
            .Components,
            .Extensions,
            .Repository,
        ]
        case .FeatureVoiceQuiz: return [
            .Core,
            .Components,
            .Extensions,
            .Repository,
            .Utility
        ]
        case .Repository: return [
            .Core,
            .Data
        ]
        case .Utility: return []
        case .ViewFactoryImpl: return [
            .Core,
            .Extensions,
            .FeatureSelectLevel,
            .FeatureSelectQuiz,
            .FeatureVoiceQuiz,
            .Repository,
            .Utility
        ]
    }}
    
    var dependenciesProducts: [PackageDescription.Target.Dependency] {
        switch self {
        case .Components: return []
        case .Core: return []
        case .CoreImpl: return []
        case .Data: return [
            .product(name: "Realm", package: "realm-swift"),     // Realm
            .product(name: "RealmSwift", package: "realm-swift") // ReamSwift
        ]
        case .Extensions: return []
        case .FeatureSelectLevel: return []
        case .FeatureSelectQuiz: return []
        case .FeatureVoiceQuiz: return [
            .product(name: "ConfettiSwiftUI", package: "ConfettiSwiftUI")
        ]
        case .Repository: return []
        case .Utility: return []
        case .ViewFactoryImpl: return []
    }}
    
    var resources: [PackageDescription.Resource] {
        switch self {
        case .Components: return []
        case .Core: return []
        case .CoreImpl: return []
        case .Data: return []
        case .Extensions: return []
        case .FeatureSelectLevel: return []
        case .FeatureSelectQuiz: return []
        case .FeatureVoiceQuiz: return []
        case .Repository: return []
        case .Utility: return [
            .copy("./SoundEffect/Resources/correct.mp3"),
            .copy("./SoundEffect/Resources/wrong.mp3")
        ]
        case .ViewFactoryImpl: return []
    }}
}

let package = Package(
    name: "Modules",
    platforms: [
        .iOS(.v16),
    ],
    products: Modules.allCases.map { .library(name: $0.rawValue, targets: [$0.rawValue])},
    dependencies: [
        .package(url: "https://github.com/simibac/ConfettiSwiftUI", from: "1.0.1"),
        .package(url: "https://github.com/realm/realm-swift", from: "10.36.0")
    ],
    targets: Modules.allCases.map {
        .target(
            name: $0.rawValue,
            dependencies: $0.dependencies.map { module in .init(stringLiteral: module.rawValue) } + $0.dependenciesProducts,
            resources: $0.resources.map { resource in return resource }
        )
    } + [
        .testTarget(
            name: "SelectLevelTests",
            dependencies: ["Core", "FeatureSelectLevel", "Repository"]
        )
    ]
)
