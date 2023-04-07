//
//  VehicleDrillOption.swift
//  
//
//  Created by 若江照仁 on 2023/03/04.
//

import Core

public enum VehicleDrillOption: String {
    case highSpeedTrain🚄
    case train🚃
    case locomotive🚂
    case airPlane🛩
    
    case bus🚌
    case ambulance🚑
    case fireEngine🚒
    case policeCar🚓
    
    case taxi🚕
    case truck🚛
    case bike🏍
    case bicycle🚲
}

extension VehicleDrillOption: DrillOption {
    public var id: Self { self }
    
    public var viewType: OptionViewType {
        switch self {
        case .highSpeedTrain🚄: return .text(title: "🚄")
        case .train🚃: return .text(title: "🚃")
        case .locomotive🚂: return .text(title: "🚂")
        case .airPlane🛩: return .text(title: "🛩")
        case .bus🚌: return .text(title: "🚌")
        case .ambulance🚑: return .text(title: "🚑")
        case .fireEngine🚒: return .text(title: "🚒")
        case .policeCar🚓: return .text(title: "🚓")
        case .taxi🚕: return .text(title: "🚕")
        case .truck🚛: return .text(title: "🚛")
        case .bike🏍: return .text(title: "🏍")
        case .bicycle🚲: return .text(title: "🚲")
        }
    }
    
    public func call(_ language: String) -> String {
        switch self {
        case .highSpeedTrain🚄: return localized("Vehicle.Option.Call.highSpeedTrain", language) ?? "High speed train"
        case .train🚃: return localized("Vehicle.Option.Call.train", language) ?? "Train"
        case .locomotive🚂: return localized("Vehicle.Option.Call.locomotive", language) ?? "Locomotive"
        case .airPlane🛩: return localized("Vehicle.Option.Call.airPlane", language) ?? "Airplane"
        case .bus🚌: return localized("Vehicle.Option.Call.bus", language) ?? "Bus"
        case .ambulance🚑: return localized("Vehicle.Option.Call.ambulance", language) ?? "Ambulance"
        case .fireEngine🚒: return localized("Vehicle.Option.Call.fireEngine", language) ?? "Fire engine"
        case .policeCar🚓: return localized("Vehicle.Option.Call.policeCar", language) ?? "Police car"
        case .taxi🚕: return localized("Vehicle.Option.Call.taxi", language) ?? "Taxi"
        case .truck🚛: return localized("Vehicle.Option.Call.truck", language) ?? "Truck"
        case .bike🏍: return localized("Vehicle.Option.Call.bike", language) ?? "Bike"
        case .bicycle🚲: return localized("Vehicle.Option.Call.bicycle", language) ?? "Bicycle"
        }
    }
    
    public static var practiceRows: [[Self]] {
        allCases.divide(into: 3)
    }
}
