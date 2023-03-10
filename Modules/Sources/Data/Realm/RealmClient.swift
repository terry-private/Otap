//
//  RealmClient.swift
//  
//
//  Created by 若江照仁 on 2023/03/05.
//

import RealmSwift
import Core

public protocol RealmClientProtocol {
    static func readDrillRecord(for id: LevelSelectorID) -> DrillRecord?
}

public enum RealmClientImpl: RealmClientProtocol {
    public static func readDrillRecord(for id: LevelSelectorID) -> DrillRecord? {
        let realm = try! Realm()
        let object = realm.object(ofType: DrillRecordObject.self, forPrimaryKey: id.rawValue)
        return object?.toDrillRecord()
    }
    
    public static func updateDrillRecord(_ drillRecord: DrillRecord) {
        let realm = try! Realm()
        let object = realm.object(ofType: DrillRecordObject.self, forPrimaryKey: drillRecord.id.rawValue)
        try! realm.write {
            if let object {
                object.star1 = drillRecord.star1
                object.star2 = drillRecord.star2
                object.star3 = drillRecord.star3
                object.time = drillRecord.time
            } else {
                let newObject = DrillRecordObject(record: drillRecord)
                realm.add(newObject)
            }
        }
    }
}
