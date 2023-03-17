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
    
    public var call: String {
        switch self {
        case .highSpeedTrain🚄: return L10n.Vehicle.Option.Call.highSpeedTrain
        case .train🚃: return L10n.Vehicle.Option.Call.train
        case .locomotive🚂: return L10n.Vehicle.Option.Call.locomotive
        case .airPlane🛩: return L10n.Vehicle.Option.Call.airPlane
        case .bus🚌: return L10n.Vehicle.Option.Call.bus
        case .ambulance🚑: return L10n.Vehicle.Option.Call.ambulance
        case .fireEngine🚒: return L10n.Vehicle.Option.Call.fireEngine
        case .policeCar🚓: return L10n.Vehicle.Option.Call.policeCar
        case .taxi🚕: return L10n.Vehicle.Option.Call.taxi
        case .truck🚛: return L10n.Vehicle.Option.Call.truck
        case .bike🏍: return L10n.Vehicle.Option.Call.bike
        case .bicycle🚲: return L10n.Vehicle.Option.Call.bicycle
        }
    }
    
    public static var practiceRows: [[Self]] {
        allCases.divide(into: 3)
    }
}
