//
//  VoiceQuizResultView.swift
//  
//
//  Created by 若江照仁 on 2023/02/28.
//

import SwiftUI
import Core
import Components
import ConfettiSwiftUI

public struct VoiceQuizResultView: View {
    @State var count: Int = 0
    private let result: GameResult
    private let star1: String
    private let star2: String
    private let star3: String
    private let dismiss: () -> Void
    
    public init(result: GameResult, star1: String, star2: String, star3: String, dismiss: @escaping () -> Void) {
        self.result = result
        self.star1 = star1
        self.star2 = star2
        self.star3 = star3
        self.dismiss = dismiss
    }
    public var body: some View {
        VStack {
            Spacer()
            switch result {
            case .success(let grades):
                Grid(verticalSpacing: 23) {
                    Text("Congratulations!!")
                        .font(.title)
                        .italic()
                        .foregroundLinearGradient(colors: result.hasFirst ? [.purple, .pink, .blue, .mint] : [], startPoint: .leading, endPoint: .trailing)
                        .padding(.bottom, 5)
                    
                    GridRow {
                        Text(star1)
                        starView(unlocked: grades.star1.unlocked, isFirst: grades.star1.isFirst)
                    }
                    
                    GridRow {
                        Text(star2)
                        starView(unlocked: grades.star2.unlocked, isFirst: grades.star2.isFirst)
                    }
                    
                    GridRow {
                        Text(star3)
                        starView(unlocked: grades.star3.unlocked, isFirst: grades.star3.isFirst)
                    }
                    
                    Divider()
                    
                    GridRow {
                        Text("タイム")
                        
                        Text(String(format: "%.2f", grades.time))
                            .font(.headline)
                            .italic()
                            .addTextAnimationBadge(grades.isNewTimeRecord)
                    }
                }
                .padding(30)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .fixedSize()
                .onTapGesture {
                    if result.hasFirst {
                        count += 1
                    }
                }
            case .gameOver:
                Text("Game Over!!")
                    .font(.title)
                    .foregroundColor(.red)
                    .padding(40)
            case .timeOver:
                Text("Time Over!!")
                    .font(.title)
                    .foregroundColor(.red)
                    .padding(40)
            }
            Spacer()
            
            BottomButton {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 26))
                Spacer()
                Text("終了")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .padding(.vertical, 30)
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .confettiCannon(counter: $count)
        .onAppear {
            if result.hasFirst {
                Task {
                    for _ in (0...5) {
                        try await Task.sleep(seconds: 0.1)
                        count += 1
                    }
                }
            }
        }
    }
    func starView(unlocked: Bool, isFirst: Bool) -> some View {
        Image(systemName: "star.fill")
            .font(.system(size: 30))
            .foregroundColor(unlocked ? .yellow : .gray)
            .addTextAnimationBadge(isFirst)
    }
}

struct VoiceQuizResultView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceQuizResultView(
            result: .success(
                .init(
                    star1: .unlocked(isFirst: true),
                    star2: .locked,
                    star3: .locked,
                    time: 43,
                    isNewTimeRecord: true)
            ),
            star1: "クリア",
            star2: "ノーミス",
            star3: "20s以内") {
                
            }
    }
}
