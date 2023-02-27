//
//  SelectLevelViewCell.swift
//  
//
//  Created by 若江照仁 on 2023/02/28.
//

import SwiftUI
import Core
import Components

public struct SelectLevelViewCell<Quiz: VoiceQuiz>: View {
    private let select: (VoiceQuizGenerator<Quiz>) -> Void
    private let generator: VoiceQuizGenerator<Quiz>
    private let star1: Bool?
    private let star2: Bool?
    private let star3: Bool?
    private let time: Double?
    private let locked: Bool
    var length: CGFloat { 135 / CGFloat(max(rowCount , columnCount)) - 5 }
    var columnCount: Int {
        switch generator.previewQuiz.options.count {
        case 0 ... 6:
            return 2
        case 7 ... 12:
            return 3
        default:
            return 4
        }
    }
    var rowCount: Int {
        generator.previewQuiz.options.count/columnCount
    }
    
    public init(generator: VoiceQuizGenerator<Quiz>, star1: Bool?, star2: Bool?, star3: Bool?, time: Double?, locked: Bool, select: @escaping (VoiceQuizGenerator<Quiz>) -> Void) {
        self.select = select
        self.generator = generator
        self.star1 = star1
        self.star2 = star2
        self.star3 = star3
        self.time = time
        self.locked = locked
    }
    
    public var body: some View {
        Button {
            select(generator)
        } label: {
            HStack{
                VStack(spacing: 5) {
                    ForEach(0..<generator.previewQuiz.options.count/columnCount, id: \.self) { index in
                        HStack(spacing: 5) {
                            ForEach(0..<columnCount, id: \.self) { i in
                                let option = generator.previewQuiz.options[index*columnCount + i]
                                option.viewType.view()
                                    .frame(width: length, height: length)
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
                .frame(width: 140, height: 140)
                VStack(alignment: .leading, spacing: 0) {
                    Text(generator.title)
                        .font(.title3)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .foregroundColor(.init(uiColor: .label))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Text("条件: \(generator.requirements)")
                        .font(.caption)
                        .foregroundColor(.init(uiColor: .secondaryLabel))
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.system(size: 30))
                            .foregroundColor(star1 == true ? .yellow : .gray)
                        Image(systemName: "star.fill")
                            .font(.system(size: 30))
                            .foregroundColor(star2 == true ? .yellow : .gray)
                        Image(systemName: "star.fill")
                            .font(.system(size: 30))
                            .foregroundColor(star3 == true ? .yellow : .gray)
                    }
                }
                .padding(.vertical, 20)
                .overlay(alignment: .topTrailing) {
                    HStack(spacing: 8) {
                        if let time {
                            CrownImage()
                                .frame(width: 16, height: 12)
                            Text("\(String(format: "%.2f", time))")
                                .font(.caption)
                        }
                        
                    }
                    .foregroundColor(.pink)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .background {
                Color(uiColor: .tertiarySystemBackground)
            }
            .cornerRadius(16)
            .padding(.horizontal, 16)
            .shadow(radius: 4)
        }
        .overlay {
            if locked {
                Image(systemName: "lock")
                    .font(.title)
                    .foregroundColor(.purple)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
            }
        }
        .disabled(locked)
    }
}

struct SelectLevelViewCell_Previews: PreviewProvider {
    typealias Quiz = VoiceQuizDummy
    static var previews: some View {
        SelectLevelViewCell(generator: VoiceQuizLevelSelectorDummy.level1.generator, star1: true, star2: true, star3: false, time: 44, locked: false) { _ in }
    }
}
