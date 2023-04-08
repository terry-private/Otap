//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/03/19.
//

import Foundation
import Core

extension DrillOption {
    func localized(_ key: String, _ language: String) -> String? {
        let path = Bundle.module.path(forResource: language, ofType: "lproj") // リソースファイルのパスを取得
        let bundle = Bundle(path: path!) // バンドルを作成
        let localizedString = bundle?.localizedString(forKey: key, value: nil, table: nil)
        return localizedString
    }
}
