//
//  RealmClient.swift
//  
//
//  Created by 若江照仁 on 2023/03/05.
//

import RealmSwift
import Core

public protocol RealmClientProtocol {
    static func readGameRecord(for id: LevelSelectorID) -> GameRecord?
}

public enum RealmClientImpl: RealmClientProtocol {
    public static func readGameRecord(for id: LevelSelectorID) -> GameRecord? {
        let realm = try! Realm()
        let object = realm.object(ofType: GameRecordObject.self, forPrimaryKey: id.rawValue)
        return object?.toGameRecord()
    }
    
    public static func updateGameRecord(_ gameRecord: GameRecord) {
        let realm = try! Realm()
        let object = realm.object(ofType: GameRecordObject.self, forPrimaryKey: gameRecord.id.rawValue)
        try! realm.write {
            if let object {
                object.star1 = gameRecord.star1
                object.star2 = gameRecord.star2
                object.star3 = gameRecord.star3
                object.time = gameRecord.time
            } else {
                let newObject = GameRecordObject(record: gameRecord)
                realm.add(newObject)
            }
        }
    }
}
