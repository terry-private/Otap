//
//  AppViewFactory.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import SwiftUI
import Core
import Drills
import FeatureSelectDrill
import FeatureMainTab

public enum AppViewFactory {
    @MainActor
    public static func mainTab() -> some View {
        MainTabView<MainTabViewFactoryImpl>()
    }
}
