//
//  MainTabView.swift
//  
//
//  Created by 若江照仁 on 2023/03/12.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Text("A")
                .tabItem {
                    Label("ドリル", systemImage: "rectangle.grid.2x2")
                }
            Text("B")
                .tabItem {
                    Label("設定", systemImage: "gear")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
