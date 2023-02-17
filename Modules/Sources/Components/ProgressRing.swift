//
//  ProgressRing.swift
//  
//
//  Created by 若江照仁 on 2023/02/13.
//

import SwiftUI

public struct ProgressRing: View {
    let progress: Double
    let foregroundColor: Color
    let lineWidth: CGFloat
    
    public init(progress: Double, foregroundColor: Color, lineWidth: CGFloat) {
        self.progress = progress
        self.foregroundColor = foregroundColor
        self.lineWidth = lineWidth
    }
    
    public var body: some View {
        Circle()
            .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
            .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            .foregroundColor(foregroundColor)
            .rotationEffect(Angle(degrees: 270.0))
            .background {
                Circle()
                    .stroke(lineWidth: lineWidth)
                    .opacity(0.3)
                    .foregroundColor(foregroundColor)
            }
            .padding(lineWidth / 2)
    }
}

struct ProgressRing_Previews: PreviewProvider {
    @State static var progress: Double = 0.42560
    
    static var previews: some View {
        HStack {
            Text(String(format: "%.1f %%", min(progress, 1.0)*100.0))
                .font(.system(size: 20, design: .monospaced))
                .bold()
            Button("add") {
                withAnimation {
                    progress += 0.01
                }
            }
            ZStack {
                ProgressRing(progress: progress, foregroundColor: .purple, lineWidth: 15)
                    .padding(36)
                
                ProgressRing(progress: progress, foregroundColor: .blue, lineWidth: 15)
                    .padding(18)
                ProgressRing(progress: progress, foregroundColor: .teal, lineWidth: 15)
            }
            Button("zero") {
                withAnimation {
                    progress = 0
                }
            }
            Button("decrease") {
                withAnimation {
                    progress -= 0.01
                }
            }
        }
    }
}
