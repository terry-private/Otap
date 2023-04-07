//
//  HiraganaDrillOption.swift
//  
//
//  Created by 若江照仁 on 2023/03/05.
//

import SwiftUI
import Core

public enum HiraganaDrillOption: String {
    case あ, い, う, え, お,
    か, き, く, け, こ,
    さ, し, す, せ, そ,
    た, ち, つ, て, と,
    な, に, ぬ, ね, の,
    は, ひ, ふ, へ, ほ,
    ま, み, む, め, も,
    や, ゆ, よ,
    ら, り, る, れ, ろ,
    わ, を, ん
}

extension HiraganaDrillOption: DrillOption {
    public var id: Self { self }
    
    public var viewType: OptionViewType {
        .text(title: call("ja"))
    }
    
    public func call(_ language: String) -> String {
        return rawValue
    }
    
    public static var practiceRows: [[Self]] {
        [
            あ行,
            か行,
            さ行,
            た行,
            な行,
            は行,
            ま行,
            や行,
            ら行,
            わ行
        ]
    }
}

public extension HiraganaDrillOption {
    static var あ行: [Self] { [.あ, .い, .う, .え, .お] }
    static var か行: [Self] { [.か, .き, .く, .け, .こ] }
    static var さ行: [Self] { [.さ, .し, .す, .せ, .そ] }
    static var た行: [Self] { [.た, .ち, .つ, .て, .と] }
    static var な行: [Self] { [.な, .に, .ぬ, .ね, .の] }
    static var は行: [Self] { [.は, .ひ, .ふ, .へ, .ほ] }
    static var ま行: [Self] { [.ま, .み, .む, .め, .も] }
    static var や行: [Self] { [.や, .ゆ, .よ] }
    static var ら行: [Self] { [.ら, .り, .る, .れ, .ろ] }
    static var わ行: [Self] { [.わ, .を, .ん] }
    
    static var review1: [Self] { randomWith(primaries: か行, all: あ行 + か行) }
    static var review2: [Self] { randomWith(primaries: さ行, all: あ行 + か行 + さ行) }
    static var review3: [Self] { randomWith(primaries: た行, all: あ行 + か行 + さ行 + た行) }
    static var review4: [Self] { randomWith(primaries: な行, all: あ行 + か行 + さ行 + た行 + な行) }
    static var review5: [Self] { randomWith(primaries: は行, all: あ行 + か行 + さ行 + た行 + な行 + は行) }
    static var review6: [Self] { randomWith(primaries: ま行, all: あ行 + か行 + さ行 + た行 + な行 + は行 + ま行) }
    static var review7: [Self] { randomWith(primaries: や行, all: あ行 + か行 + さ行 + た行 + な行 + は行 + ま行 + や行) }
    static var review8: [Self] { randomWith(primaries: ら行, all: あ行 + か行 + さ行 + た行 + な行 + は行 + ま行 + や行 + ら行) }
    static var review9: [Self] { randomWith(primaries: わ行, all: あ行 + か行 + さ行 + た行 + な行 + は行 + ま行 + や行 + ら行 + わ行) }
    
    static func randomWith(primaries: [Self], all: [Self]) -> [Self] {
        let primary = primaries.randomElement()!
        var allWithoutPrimary = Set(all)
        allWithoutPrimary.remove(primary)
        return [primary] + allWithoutPrimary.toArray().prefix(3).shuffled()
    }
}
