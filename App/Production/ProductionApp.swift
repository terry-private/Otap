//
//  ProductionApp.swift
//  TapDrillForKids
//
//  Created by 若江照仁 on 2023/01/10.
//

import SwiftUI
import AppProduction

@main
struct ProductionApp: App {
    var body: some Scene {
        WindowGroup {
            AppViewFactory.mainTab()
        }
    }
}
