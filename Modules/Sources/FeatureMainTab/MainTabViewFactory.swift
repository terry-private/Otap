//
//  MainTabViewFactory.swift
//  
//
//  Created by 若江照仁 on 2023/03/12.
//

import SwiftUI

public protocol MainTabViewFactoryProtocol {
    static var drillView: AnyView { get }
    static var settingView: AnyView { get }
}

#if DEBUG
public enum MainTabViewFactoryDummy: MainTabViewFactoryProtocol {
    public static var drillView: AnyView { AnyView(Text("ドリル")) }
    public static var settingView: AnyView { AnyView(Text("設定")) }
}
#endif
