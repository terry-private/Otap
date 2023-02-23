// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
// 👤⚛
// 
// 🌐
enum Modules: String, CaseIterable {
    case Components
    case Core
    case CoreImpl
    case Data
    case Extensions
    case Feature
    case FeatureImpl
    case Repository
    case RepositoryImpl
    case UseCase
    case UseCaseImpl
    
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
            
        case .Feature: return [
            .Core,
            .Components,
            .Extensions,
            .UseCase,
            .UseCaseImpl
        ]
        case .FeatureImpl: return [
            .CoreImpl,
            .Components,
            .Extensions,
            .Feature,
            .UseCaseImpl,
            .RepositoryImpl
        ]
        case .Repository: return [
            .Core
        ]
        case .RepositoryImpl: return [
            .Core,
            .Data,
            .Repository
        ]
        case .UseCase: return [
            .Core
        ]
        case .UseCaseImpl: return [
            .Core,
            .UseCase
        ]
    }}
    
    var resources: [PackageDescription.Resource] {
        switch self {
        case .Components: return []
        case .Core: return []
        case .CoreImpl: return []
        case .Data: return []
        case .Extensions: return []
        case .Feature: return []
        case .FeatureImpl: return []
        case .Repository: return []
        case .RepositoryImpl: return []
        case .UseCase: return []
        case .UseCaseImpl: return [
            .copy("./SoundEffect/Resources/correct.mp3"),
            .copy("./SoundEffect/Resources/wrong.mp3")
        ]
    }}
}


let package = Package(
    name: "Modules",
    platforms: [
        .iOS(.v16),
    ],
    products: Modules.allCases.map { .library(name: $0.rawValue, targets: [$0.rawValue])},
    dependencies: [],
    targets: Modules.allCases.map {
        .target(
            name: $0.rawValue,
            dependencies: $0.dependencies.map { module in .init(stringLiteral: module.rawValue) },
            resources: $0.resources.map { resource in return resource }
        )
    }
)
