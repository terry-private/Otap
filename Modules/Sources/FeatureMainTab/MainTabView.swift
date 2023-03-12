//
//  MainTabView.swift
//  
//
//  Created by 若江照仁 on 2023/03/12.
//

import SwiftUI

struct MainTabView<Factory: MainTabViewFactoryProtocol>: View {
    var body: some View {
        TabView {
            Factory.drillView
                .tabItem {
                    Label("ドリル", systemImage: "rectangle.grid.2x2")
                }
            Factory.settingView
                .tabItem {
                    Label("設定", systemImage: "gear")
                }
        }
    }
}

#if DEBUG
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView<MainTabViewFactoryDummy>()
    }
}
#endif
