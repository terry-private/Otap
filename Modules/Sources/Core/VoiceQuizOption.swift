//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/08.
//

import SwiftUI
import Extensions

public enum OptionViewType: Hashable {
    case color(Color)
    case text(title: String, textColor: Color, backgroundColor: Color)
    case image(name: String)
    case systemIcon(systemName: String, foregroundColor: Color = .cyan, backgroundColor: Color = .init(uiColor: .systemFill))
    
    @ViewBuilder
    public func view() -> some View {
        switch self {
        case let .color(foregroundColor):
            Rectangle()
                .fill(foregroundColor.gradient)
        case let .text(title, textColor, backgroundColor):
            Text(title)
                .font(.system(size: 200))
                .minimumScaleFactor(0.05)
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background { backgroundColor }
        case let .image(name):
            Image(name)
                .resizable()
        case let .systemIcon(systemName, foregroundColor, backgroundColor):
            Image(systemName: systemName)
                .resizable()
                .scaleEffect(x: 0.8, y: 0.8)
                .foregroundColor(foregroundColor)
                .background{ backgroundColor }
        }
    }
}

public protocol VoiceQuizOption: Identifiable, Hashable, CaseIterable {
    var viewType: OptionViewType { get }
    var call: String { get }
}

public extension VoiceQuizOption {
    static func randoms(by count: Int = allCases.count) -> [Self] {
        Self.allCases
            .shuffled()
            .prefix(min(count, Self.allCases.count))
            .toArray()
    }
}
