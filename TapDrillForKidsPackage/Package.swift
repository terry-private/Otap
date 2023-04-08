// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

enum Modules: String, CaseIterable, Hashable {
    case AppViewFactory
    case Components
    case Core
    case Drills
    case Extensions
    case FeatureDrill
    case FeatureMainTab
    case FeaturePrepareMode
    case FeatureSelectDrill
    case FeatureSelectLevel
    case FeatureSetting
    case Repository
    case RepositoryImpl
    case Utility
    
    var dependencies: [Self] {
        switch self {
        case .AppViewFactory: return [
            .Core,
            .Drills,
            .Extensions,
            .FeatureDrill,
            .FeatureMainTab,
            .FeaturePrepareMode,
            .FeatureSelectLevel,
            .FeatureSelectDrill,
            .FeatureSetting,
            .RepositoryImpl,
            .Utility
        ]
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
            .Core,
            .Components,
            .Extensions,
            .Utility
        ]
        case .Repository: return [
            .Core,
        ]
        case .RepositoryImpl: return [
            .Core,
            .Repository
        ]
        case .Utility: return [
            .Core,
            .Repository
        ]
    }}
    
    var dependenciesProducts: [PackageDescription.Target.Dependency] {
        switch self {
        case .AppViewFactory: return []
        case .Components: return []
        case .Core: return []
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
        case .RepositoryImpl: return [
            .product(name: "Realm", package: "realm-swift"),     // Realm
            .product(name: "RealmSwift", package: "realm-swift") // ReamSwift
        ]
        case .Utility: return []
    }}
    
    var dependenciesPlugins: [PackageDescription.Target.PluginUsage] {
        switch self {
        case .AppViewFactory: return []
        case .Components: return []
        case .Core: return []
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
            .licensesPlugin,
            .swiftgen
        ]
        case .Repository: return []
        case .RepositoryImpl: return []
        case .Utility: return []
        }
    }
    
    var path: String? {
        switch self {
        case .AppViewFactory: return nil
        case .Components: return nil
        case .Core: return nil
        case .Drills: return nil
        case .Extensions: return nil
        case .FeatureDrill: return "./Sources/Features/Drill"
        case .FeatureMainTab: return "./Sources/Features/MainTab"
        case .FeaturePrepareMode: return "./Sources/Features/PrepareMode"
        case .FeatureSelectDrill: return "./Sources/Features/SelectDrill"
        case .FeatureSelectLevel: return "./Sources/Features/SelectLevel"
        case .FeatureSetting: return "./Sources/Features/Setting"
        case .Repository: return "./Sources/Data/Repository"
        case .RepositoryImpl: return "./Sources/Data/RepositoryImpl"
        case .Utility: return nil
        }
    }
    
    var resources: [PackageDescription.Resource] {
        switch self {
        case .AppViewFactory: return []
        case .Components: return []
        case .Core: return []
        case .RepositoryImpl: return []
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
    static let licensesPlugin: Self = .plugin(name: "LicensesPlugin", package: "LicensesPlugin")
}

let package = Package(
    name: "TapDrillForKidsPackage",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
    ],
    products: Modules.allCases.map { .library(name: $0.rawValue, targets: [$0.rawValue])},
    dependencies: [
        .package(url: "https://github.com/simibac/ConfettiSwiftUI", from: "1.0.1"),
        .package(url: "https://github.com/realm/realm-swift", from: "10.36.0"),
        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.6.2"),
        .package(url: "https://github.com/maiyama18/LicensesPlugin", from: "0.1.3")
    ],
    targets: Modules.allCases.map {
        .target(
            name: $0.rawValue,
            dependencies: $0.dependencies
                .map { module in
                    .init(stringLiteral: module.rawValue)
                } + $0.dependenciesProducts,
            path: $0.path,
            resources: $0.resources,
            plugins: $0.dependenciesPlugins
        )
    } + TestModule.allCases.map {
        .testTarget(
            name: $0.rawValue,
            dependencies: $0.dependencies.map { module in .init(stringLiteral: module.rawValue) }
        )
    }
)
