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
            
        case .Feature: return [
            .Core,
            .Components,
            .Extensions,
            .Repository,
            .Utility,
        ]
        case .Repository: return [
            .Core
        ]
        case .Utility: return []
        case .ViewFactoryImpl: return [
            .Core,
            .Extensions,
            .Feature,
            .Repository,
            .Utility
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
    dependencies: [],
    targets: Modules.allCases.map {
        .target(
            name: $0.rawValue,
            dependencies: $0.dependencies.map { module in .init(stringLiteral: module.rawValue) },
            resources: $0.resources.map { resource in return resource }
        )
    }
)
