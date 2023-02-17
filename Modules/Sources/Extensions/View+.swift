//
//  View+.swift
//  
//
//  Created by 若江照仁 on 2023/02/07.
//

import SwiftUI

// MARK: - 🚪private
private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

private struct OnSpacer: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Spacer()
        }
        .overlay {
            content
        }
    }
}

// MARK: - 🌎public
public extension View {
    func onChangeFrame( _ block: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader {
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: $0.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: block)
    }
    
    func layoutLikeSpacer() -> some View {
        modifier(OnSpacer())
    }
}
