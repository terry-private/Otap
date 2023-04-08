//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/04/01.
//

import Foundation
import Core
import Repository

extension RepositoryImpl: ConfigRepository {
    public static var drillPanelLeadingPadding: CGFloat {
        get {
            UserDefaultsClient.drillPanelLeadingPadding
        }
        set {
            UserDefaultsClient.drillPanelLeadingPadding = newValue
        }
    }
    public static var drillPanelTrailingPadding: CGFloat {
        get {
            UserDefaultsClient.drillPanelTrailingPadding
        }
        set {
            UserDefaultsClient.drillPanelTrailingPadding = newValue
        }
    }
}
