//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Core

public final actor LocaleCache {
    private init() {}
    public static var shared: LocaleCache = .init()
    
    public var records: [LevelSelectorID: GameRecord] = [
        .shapeBasic1: .init(),
        .colorBasic1: .init(),
        .funnyAnimalBasic1: .init(),
        .creatureAnimal1: .init(),
        .fruitsAndVegetablesVegetable1: .init()
    ]
    
    public func update(id: LevelSelectorID, _ gameRecord: GameRecord) {
        records[id, default: .init()].merge(gameRecord)
    }
}
