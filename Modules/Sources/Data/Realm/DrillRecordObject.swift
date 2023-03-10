//
//  DrillRecordObject.swift
//  
//
//  Created by 若江照仁 on 2023/03/05.
//

import RealmSwift
import Core

final class DrillRecordObject: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var time: Double? = nil
    @Persisted var star1: Bool = false
    @Persisted var star2: Bool = false
    @Persisted var star3: Bool = false
    
    convenience init(record: DrillRecord) {
        self.init()
        id = record.id.rawValue
        time = record.time
        star1 = record.star1
        star2 = record.star2
        star3 = record.star3
    }
    
    func toDrillRecord() -> DrillRecord {
        .init(
            id: .init(rawValue: id)!,
            time: self.time,
            star1: self.star1,
            star2: self.star2,
            star3: self.star3
        )
    }
}
