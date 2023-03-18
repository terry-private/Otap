// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

enum Modules: String, CaseIterable, Hashable {
    case Components
    case Core
    case Data
    case Drills
    case Extensions
    case FeatureDrill
    case FeatureMainTab
    case FeaturePrepareMode
    case FeatureSelectDrill
    case FeatureSelectLevel
    case FeatureSetting
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
        case .Drills: return [
            .Core,
            .Extensions
        ]
            
        case .Data: return [
            .Core
        ]
            
        case .Extensions: return []
            
        case .FeatureDrill: return [
            .Core,
            .Components,
            .Extensions,
            .Repository,
            .Utility
        ]
        case .FeatureMainTab: return []
        case .FeaturePrepareMode: return [
            .Core,
            .Components,
            .Extensions,
            .Utility
        ]
        case .FeatureSelectDrill: return [
            .Core,
            .Components,
            .Extensions,
            .Repository,
        ]
        case .FeatureSelectLevel: return [
            .Core,
            .Components,
            .Extensions,
            .Repository,
        ]
        case .FeatureSetting: return [
            .Extensions,
            .Utility
        ]
        case .Repository: return [
            .Core,
            .Data
        ]
        case .Utility: return []
        case .ViewFactoryImpl: return [
            .Core,
            .Drills,
            .Extensions,
            .FeatureDrill,
            .FeatureMainTab,
            .FeaturePrepareMode,
            .FeatureSelectLevel,
            .FeatureSelectDrill,
            .FeatureSetting,
            .Repository,
            .Utility
        ]
    }}
    
    var dependenciesProducts: [PackageDescription.Target.Dependency] {
        switch self {
        case .Components: return []
        case .Core: return []
        case .Data: return [
            .product(name: "Realm", package: "realm-swift"),     // Realm
            .product(name: "RealmSwift", package: "realm-swift") // ReamSwift
        ]
        case .Drills: return []
        case .FeatureMainTab: return []
        case .Extensions: return []
        case .FeatureDrill: return [
            .product(name: "ConfettiSwiftUI", package: "ConfettiSwiftUI")
        ]
        case .FeaturePrepareMode: return []
        case .FeatureSelectDrill: return []
        case .FeatureSelectLevel: return []
        case .FeatureSetting: return []
        case .Repository: return []
        case .Utility: return []
        case .ViewFactoryImpl: return []
    }}
    
    var dependenciesPlugins: [PackageDescription.Target.PluginUsage] {
        switch self {
        case .Components: return []
        case .Core: return []
        case .Data: return []
        case .Drills: return [
            .swiftgen
        ]
        case .Extensions: return []
        case .FeatureDrill: return [
            .swiftgen
        ]
        case .FeatureMainTab: return [
            .swiftgen
        ]
        case .FeaturePrepareMode: return []
        case .FeatureSelectDrill: return [
            .swiftgen
        ]
        case .FeatureSelectLevel: return [
            .swiftgen
        ]
        case .FeatureSetting: return [
            .swiftgen
        ]
        case .Repository: return []
        case .Utility: return []
        case .ViewFactoryImpl: return []
        }
    }
    
    var resources: [PackageDescription.Resource] {
        switch self {
        case .Components: return []
        case .Core: return []
        case .Data: return []
        case .Drills: return []
        case .Extensions: return []
        case .FeatureDrill: return []
        case .FeatureMainTab: return [.process("Resources")]
        case .FeaturePrepareMode: return []
        case .FeatureSelectDrill: return []
        case .FeatureSelectLevel: return []
        case .FeatureSetting: return []
        case .Repository: return []
        case .Utility: return [
            .copy("./SoundEffect/Resources/correct.mp3"),
            .copy("./SoundEffect/Resources/wrong.mp3")
        ]
        case .ViewFactoryImpl: return []
    }}
}

enum TestModule: String, CaseIterable {
    case TapDrillForKidsTests
    
    var dependencies: [Modules] {
        switch self {
        case .TapDrillForKidsTests: return [
            .Core,
            .FeatureDrill,
            .FeatureSelectLevel,
            .Repository,
            .Utility
        ]
    }}
}

private extension PackageDescription.Target.PluginUsage {
    static let swiftgen: Self = .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
}

let package = Package(
    name: "Modules",
    defaultLocalization: "ja",
    platforms: [
        .iOS(.v16),
    ],
    products: Modules.allCases.map { .library(name: $0.rawValue, targets: [$0.rawValue])},
    dependencies: [
        .package(url: "https://github.com/simibac/ConfettiSwiftUI", from: "1.0.1"),
        .package(url: "https://github.com/realm/realm-swift", from: "10.36.0"),
        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.6.2")
    ],
    targets: Modules.allCases.map {
        .target(
            name: $0.rawValue,
            dependencies: $0.dependencies.map { module in .init(stringLiteral: module.rawValue) } + $0.dependenciesProducts,
            resources: $0.resources.map { resource in return resource },
            plugins: $0.dependenciesPlugins
        )
    } + TestModule.allCases.map {
        .testTarget(
            name: $0.rawValue,
            dependencies: $0.dependencies.map { module in .init(stringLiteral: module.rawValue) }
        )
    }
)
