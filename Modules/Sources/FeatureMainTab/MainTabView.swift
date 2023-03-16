//
//  MainTabView.swift
//  
//
//  Created by 若江照仁 on 2023/03/12.
//

import SwiftUI

public struct MainTabView<Factory: MainTabViewFactoryProtocol>: View {
    public init() {}
    public var body: some View {
        TabView {
            NavigationStack {
                Factory.selectDrillView
            }
            .tabItem {
                Label(L10n.drill, systemImage: "rectangle.grid.2x2")
            }
            
            NavigationStack {
                Factory.settingView
            }
            .tabItem {
                Label(L10n.setting, systemImage: "gear")
            }
        }
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            UITabBar.appearance().scrollEdgeAppearance = appearance
            UITabBar.appearance().standardAppearance = appearance
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
