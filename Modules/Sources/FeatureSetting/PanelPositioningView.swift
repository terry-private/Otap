//
//  SwiftUIView.swift
//  
//
//  Created by 若江照仁 on 2023/04/01.
//

import SwiftUI
import Components
import Repository

struct DummyPanel: Identifiable {
    let id = UUID()
}

struct PanelPositioningView: View {
    let bottomHeight: CGFloat = 140 + 30 + 48
    @State var leadingPadding: CGFloat
    @State var trailingPadding: CGFloat
    @State var panelCount: Int = 16
    let panelCounts: [Int] = [2, 4, 6, 9, 12, 16]
    var panels: [DummyPanel] {
        (0..<panelCount).map { _ in .init() }
    }
    typealias repository = RepositoryImpl
    init() {
        leadingPadding = repository.drillPanelLeadingPadding
        trailingPadding = repository.drillPanelTrailingPadding
        print(leadingPadding, trailingPadding)
    }
    var body: some View {
        VStack {
            SquareGrid(panels) { _ in
                Button {
                } label: {
                    Color.accentColor
                }
            }
            .padding(.leading, leadingPadding * 60)
            .padding(.trailing, trailingPadding * 60)
            
            VStack(alignment: .leading) {
                Section("パネル数") {
                    Picker("パネル数", selection: $panelCount) {
                        ForEach(panelCounts, id: \.self) { count in
                            Text("\(count)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Spacer()
                Section("左右位置調整") {
                    HStack(spacing: 20) {
                        Slider(
                            value: .init(
                                get: {
                                    repository.drillPanelLeadingPadding
                                },
                                set: {
                                    leadingPadding = $0
                                    repository.drillPanelLeadingPadding = $0
                                }
                            )
                        )
                        
                        Slider(
                            value: .init(
                                get: {
                                    repository.drillPanelTrailingPadding
                                },
                                set: {
                                    trailingPadding = $0
                                    repository.drillPanelTrailingPadding = $0
                                }
                            )
                        )
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    }
                }
                
            }
            .padding(20)
            .frame(height: bottomHeight)
        }
    }
}

struct PanelPositioningView_Previews: PreviewProvider {
    static var previews: some View {
        PanelPositioningView()
    }
}
