//
//  TapDrillForKidsApp.swift
//  TapDrillForKids
//
//  Created by 若江照仁 on 2023/01/10.
//

import SwiftUI
import ViewFactoryImpl

@main
struct TapDrillForKidsApp: App {
    var body: some Scene {
        WindowGroup {
            AppViewFactory.mainTab()
        }
    }
}
