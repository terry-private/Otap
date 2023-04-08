//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Core

final actor LocaleCache {
    private init() {}
    static var shared: LocaleCache = .init()
    
    var records: [LevelSelectorID: DrillRecord] = [
        .shapeBasic1: .init(id: .shapeBasic1),
        .colorBasic1: .init(id:.colorBasic1),
        .funnyAnimalBasic1: .init(id: .funnyAnimalBasic1),
        .creatureAnimal1: .init(id: .creatureAnimal1),
        .fruitsAndVegetablesVegetable1: .init(id: .fruitsAndVegetablesVegetable1),
        .vehicleBasic1: .init(id: .vehicleBasic1),
        .nationalFlagAsia1: .init(id: .nationalFlagAsia1),
        .numberDice123: .init(id: .numberDice123),
        .hiraganaあ行: .init(id: .hiraganaあ行)
    ]
    
    func update(id: LevelSelectorID, _ drillRecord: DrillRecord) {
        records[id, default: .init(id: id)].merge(drillRecord)
    }
}
