// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
// 👤⚛
// 
// 🌐
enum Modules: String, CaseIterable {
    case Components
    case Core
    case Extensions
    case Feature
    case Repository
    case RepositoryImpl
    case SoundEffectInteractor
    case SoundEffectUseCase
    case SoundQuizInteractor
    case SoundQuizUseCase
    
    var dependencies: [Self] {
        switch self {
        case .Components: return [
            .Extensions
        ]
            
        case .Core: return [
            .Extensions
        ]
            
        case .Extensions: return []
            
        case .Feature: return [
            .Core,
            .Components,
            .Extensions,
            .SoundEffectUseCase
        ]
        case .Repository: return [
            .Core
        ]
        case .RepositoryImpl: return [
            .Core,
            .Repository
        ]
        case .SoundEffectInteractor: return [
            .SoundEffectUseCase
        ]
        case .SoundEffectUseCase: return []
        case .SoundQuizInteractor: return [
            .Core,
            .SoundQuizUseCase
        ]
        case .SoundQuizUseCase: return [
            .Core
        ]
    }}
    
    var resources: [String] {
        switch self {
        case .Components: return []
        case .Core: return []
        case .Extensions: return []
        case .Feature: return []
        case .Repository: return []
        case .RepositoryImpl: return []
        case .SoundEffectUseCase: return []
        case .SoundEffectInteractor: return [
            "./Resources/correct.mp3",
            "./Resources/wrong.mp3"
        ]
        case .SoundQuizInteractor: return []
        case .SoundQuizUseCase: return []
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
            resources: $0.resources.map { str in .copy(str) }
        )
    }
)
