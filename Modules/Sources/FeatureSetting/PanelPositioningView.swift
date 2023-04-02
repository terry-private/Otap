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
    typealias repository = RepositoryImpl
    // Drill画面上部.height:140 + padding:30 + BottomButton.height: 48
    let bottomHeight: CGFloat = 140 + 30 + 48
    let panelCounts: [Int] = [2, 4, 6, 9, 12, 16]
    var panels: [DummyPanel] {
        (0..<panelCount).map { _ in .init() }
    }
    
    @State var leadingPadding: CGFloat
    @State var trailingPadding: CGFloat
    @State var panelCount: Int = 16
    
    init() {
        leadingPadding = repository.drillPanelLeadingPadding
        trailingPadding = repository.drillPanelTrailingPadding
    }
    
    var body: some View {
        VStack(spacing: 0) {
            panelView
                .padding(.leading, leadingPadding)
                .padding(.trailing, trailingPadding)
            
            VStack(alignment: .leading) {
                panelCountSection
                
                Spacer()
                
                horizontalPaddingAdjustmentSection
                
            }
            .padding(20)
            .frame(height: bottomHeight)
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension PanelPositioningView {
    var panelView: some View {
        SquareGrid(panels) { _ in
            Button {
            } label: {
                Color.accentColor
            }
        }
    }
    
    var panelCountSection: some View {
        Section(L10n.PanelPositioningView.PanelCount.title) {
            Picker(L10n.PanelPositioningView.PanelCount.title, selection: $panelCount) {
                ForEach(panelCounts, id: \.self) { count in
                    Text("\(count)")
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    var horizontalPaddingAdjustmentSection: some View {
        Section(L10n.PanelPositioningView.HorizontalPaddingAdjustment.title) {
            HStack(spacing: 20) {
                Slider(
                    value: .init(
                        get: {
                            repository.drillPanelLeadingPadding / 60
                        },
                        set: {
                            leadingPadding = $0 * 60
                            repository.drillPanelLeadingPadding = $0 * 60
                        }
                    )
                )
                
                Slider(
                    value: .init(
                        get: {
                            repository.drillPanelTrailingPadding / 60
                        },
                        set: {
                            trailingPadding = $0 * 60
                            repository.drillPanelTrailingPadding = $0 * 60
                        }
                    )
                )
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
        }
    }
}

struct PanelPositioningView_Previews: PreviewProvider {
    static var previews: some View {
        PanelPositioningView()
    }
}
