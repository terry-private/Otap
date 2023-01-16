//
//  OAStackView.swift
//  
//
//  Created by 若江照仁 on 2023/01/14.
//

import SwiftUI

public struct OAStackView<C: View>: View {
    private let isReverse: Bool
    private let content: C
    
    @State private var isVertical: Bool = true
    
    /// Dynamic StackView with orientation when Portrait: VStack, Landscape: HStack
    /// - Parameters:
    ///   - isReverse: true -> VStack when landscape, default: false
    ///   - viewBuilder: can stack some view limit 10
    public init(isReverse: Bool = false, @ViewBuilder viewBuilder: @escaping () -> C = { EmptyView() }) {
        self.isReverse = isReverse
        self.content = viewBuilder()
        updateOrientation()
    }
    
    public var body: some View {
        ZStack {
            if isVertical {
                VStack {
                    content
                }
            } else {
                HStack {
                    content
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            updateOrientation()
        }
    }
    
    private func updateOrientation() {
        switch UIDevice.current.orientation {
        case .portrait:
            isVertical = !isReverse
        case .landscapeRight, .landscapeLeft:
            isVertical = isReverse
        default:
            break
        }
    }
}

struct OAStackView_Previews: PreviewProvider {
    static var previews: some View {
        OAStackView {
            Text("1")
            Text("2")
        }
    }
}
