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
        .colorBasic1: .init(),
        .animalFunny1: .init(),
        .animalAnimal1: .init(),
        .animalBird: .init(),
        .animalReptile: .init(),
        .animalMarineLife: .init(),
        .animalInsect: .init()
    ]
    
    public func update(id: LevelSelectorID, _ gameRecord: GameRecord) {
        records[id, default: .init()].merge(gameRecord)
    }
}
