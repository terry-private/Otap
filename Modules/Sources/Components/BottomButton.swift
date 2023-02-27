//
//  SwiftUIView.swift
//  
//
//  Created by 若江照仁 on 2023/02/28.
//

import SwiftUI

public struct BottomButton<V: View>: View {
    let action: () -> Void
    let label: () -> V
    public init(action: @escaping() -> Void, @ViewBuilder label: @escaping () -> V) {
        self.action = action
        self.label = label
    }
    public var body: some View {
        Button {
            action()
        } label: {
            Capsule()
                .overlay {
                    HStack {
                        label()
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                }
                .frame(width: 180, height: 48)
                .shadow(color: .black.opacity(0.2), radius: 8)
        }
    }
}

struct BottomButton_Previews: PreviewProvider {
    @State static var bool: Bool = false
    static var previews: some View {
        BottomButton {
            bool.toggle()
        } label: {
            Text(bool ? "yes" : "no")
        }
    }
}
