//
//  TimeSecondsView.swift
//  
//
//  Created by 若江照仁 on 2023/02/21.
//

import SwiftUI

public struct TimeSecondsView: View {
    private let time: Double
    private let secondsFont: UIFont
    private var decimalFont: UIFont {
        .systemFont(ofSize: secondsFont.xHeight * secondsFont.pointSize / secondsFont.capHeight)
    }
    public init(_ time: Double = 0, secondsFont: UIFont = .preferredFont(forTextStyle: .title3)) {
        self.time = time
        self.secondsFont = secondsFont
    }
    public var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 0) {
            Text("\(String(format: "%02d", Int(time)))")
                .font(.init(secondsFont))
                .bold()
                .monospacedDigit()
                .fixedSize()
            Text(".\(String(format: "%02d", Int(time * 100) - Int(time) * 100))")
                .font(.init(decimalFont))
                .monospacedDigit()
                .fixedSize()
        }
        .offset(x: 0)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    @State static var showGridLine: Bool = true
    static var previews: some View {
        VStack {
            HStack {
                circle(width: 40, color: .purple, time: 22.22, secondsSize: 11)
                circle(width: 40, color: .purple, time: 0, secondsSize: 11)
            }
            HStack {
                circle(width: 50, color: .indigo, time: 22.22, secondsSize: 18)
                circle(width: 50, color: .indigo, time: 0, secondsSize: 18)
            }
            HStack {
                circle(width: 60, color: .indigo, time: 22.22, secondsSize: 20)
                circle(width: 60, color: .indigo, time: 0, secondsSize: 20)
            }
            HStack {
                circle(width: 100, color: .mint, time: 22.22, secondsSize: 40, decimalSize: 20)
                circle(width: 100, color: .mint, time: 0, secondsSize: 40, decimalSize: 20)
            }
        }
    }
    static func circle(width: CGFloat, color: Color, time: Double, secondsSize: CGFloat, decimalSize: CGFloat = 11) -> some View {
        Circle()
            .frame(width: width)
            .foregroundColor(color.opacity(0.6))
            .background {
                Color.red.frame(height: 1).opacity(showGridLine ? 1 : 0)
                Color.red.frame(width: 1).opacity(showGridLine ? 1 : 0)
            }
            .overlay { TimeSecondsView(time, secondsFont: .systemFont(ofSize: secondsSize)) }
    }
}
