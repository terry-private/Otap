//
//  TextAnimationView.swift
//  
//
//  Created by 若江照仁 on 2023/02/16.
//

import SwiftUI
import Foundation

public extension View {
    func addTextAnimationBadge(
        _ isAdd: Bool,
        text: String = "New!!",
        size: CGFloat = 12,
        x: CGFloat = 30,
        y: CGFloat = -13
    ) -> some View {
        overlay(alignment: .topTrailing) {
                if isAdd {
                    TextAnimationView(
                        text: text,
                        font: .system(size: size),
                        italic: true,
                        foregroundColor: .red
                    )
                    .offset(x: x, y: y)
                }
            }
    }
}

public struct TextAnimationView: View {
    struct AnimationData: Identifiable {
        var id: Int
        var text: String
        var delay: TimeInterval
        var ty: CGFloat
    }
    
    struct AnimationText: View {
        let transY: CGFloat
        let font: Font?
        let italic: Bool
        let foregroundColor: Color
        let text: String
        var body: some View {
            Text(text)
                .font(font)
                .italic(italic)
                .foregroundColor(foregroundColor)
                .offset(x: 0, y: transY)
        }
    }
    
    let font: Font?
    let italic: Bool
    let foregroundColor: Color
    let items: [AnimationData]
    @State var transY: [CGFloat]
    
    public init(text: String, font: Font? = nil, italic: Bool = false, foregroundColor: Color = .init(uiColor: .label)) {
        self.font = font
        self.italic = italic
        self.foregroundColor = foregroundColor
        items = text.enumerated().map { .init(
            id: $0.offset,
            text: String($0.element),
            delay: .init(CGFloat($0.offset) * (0.4 / CGFloat(text.count - 1))),
            ty: -2 - CGFloat($0.offset) * (10 / CGFloat(text.count - 1))
        )}
        _transY = .init(initialValue: .init(repeating: 0 ,count: text.count))
    }
    
    var animation = Animation.easeInOut(duration: 0.2)
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(items) { item in
                AnimationText(
                    transY: transY[item.id],
                    font: font,
                    italic: italic,
                    foregroundColor: foregroundColor,
                    text: item.text
                )
            }
        }
        .onAppear {
            Task {
                try await animateDots()
            }
        }
    }
    func animateDots() async throws {
        for item in items {
            Task.detached { @MainActor in
                try await Task.sleep(seconds: item.delay)
                self.animateDot(binding: $transY[item.id], animationData: item)
            }
        }
        try await Task.sleep(seconds: 6)
        try await animateDots()
    }
    func animateDot(binding: Binding<CGFloat>, animationData: AnimationData) {
        withAnimation(animation) {
            binding.wrappedValue = animationData.ty
        }
        Task { @MainActor in
            try await Task.sleep(seconds: 0.2)
            withAnimation(animation) {
                binding.wrappedValue = 0
            }
        }
    }
}

struct TextAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TextAnimationView(text: "New!!", foregroundColor: .red)
    }
}
