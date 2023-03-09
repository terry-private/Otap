//
//  NumberQuizOption.swift
//  
//
//  Created by 若江照仁 on 2023/03/05.
//

import SwiftUI
import Core

public enum NumberQuizOption: String {
    case dice1
    case dice2
    case dice3
    
    case dice4
    case dice5
    case dice6
    
    case finger1
    case finger2
    case finger3
    case finger4
    case finger5
    
    case numeral0
    case numeral1
    case numeral2
    case numeral3
    
    case numeral4
    case numeral5
    case numeral6
    case numeral7
    
    case numeral8
    case numeral9
    case numeral10
    
    private static var uniqueNumberOptions: [String: [Self]] = {
        return allCases
            .reduce(into: [:]) { numberOptions, option in
                numberOptions[option.call, default: []].append(option)
            }
    }()
    
    public static func randomUniqueNumberOptions(of count: Int) -> [Self] {
        uniqueNumberOptions
            .keys
            .shuffled()
            .prefix(count)
            .map { uniqueNumberOptions[$0]!.randomElement()! }
    }
}

extension NumberQuizOption: VoiceQuizOption {
    public var id: Self { self }
    
    public var viewType: OptionViewType {
        switch self {
        case .dice1, .dice2, .dice3, .dice4, .dice5, .dice6, .finger1, .finger2, .finger3, .finger4, .finger5:
            return .image(uiImage: .init(named: rawValue, in: .module, with: nil)!)
        default:
            return .text(title: call)
        }
    }
    
    public var call: String {
        switch self {
        case .dice1: return "1"
        case .dice2: return "2"
        case .dice3: return "3"
        case .dice4: return "4"
        case .dice5: return "5"
        case .dice6: return "6"
        case .finger1: return "1"
        case .finger2: return "2"
        case .finger3: return "3"
        case .finger4: return "4"
        case .finger5: return "5"
        case .numeral0: return "0"
        case .numeral1: return "1"
        case .numeral2: return "2"
        case .numeral3: return "3"
        case .numeral4: return "4"
        case .numeral5: return "5"
        case .numeral6: return "6"
        case .numeral7: return "7"
        case .numeral8: return "8"
        case .numeral9: return "9"
        case .numeral10: return "10"
        }
    }
    
    public static var practiceRows: [[Self]] {
        (0..<allCases.count/4).map { rowIndex in
            allCases[rowIndex*4..<rowIndex*4+4].map { $0 }
        }
    }
}

struct SquareGrid_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach(NumberQuizOption.allCases) { option in
                option.viewType.view()
                    .frame(width: 100, height: 100)
                    .font(.title)
            }
        }
    }
}
