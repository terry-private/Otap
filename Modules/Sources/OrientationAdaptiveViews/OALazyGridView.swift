//
//  OALazyGridView.swift
//  
//
//  Created by 若江照仁 on 2023/01/16.
//

import SwiftUI

public struct OALazyGridView<C: View>: View {
    private let isReverse: Bool
    
    private let columns: [GridItem]
    private let rows: [GridItem]
    
    private let horizontalAlignment: HorizontalAlignment
    private let verticalAlignment: VerticalAlignment
    
    private let spacing: CGFloat?
    
    private let pinnedViews: PinnedScrollableViews
    
    private let content: C
    
    @State private var isVertical: Bool = true
    
    public init(isReverse: Bool = false, gridItems: [GridItem], alignment: Alignment = .center, spacing: CGFloat? = nil, pinnedViews: PinnedScrollableViews = .init(), @ViewBuilder viewBuilder: @escaping () -> C = { EmptyView() }) {
        self.isReverse = isReverse
        self.columns = gridItems
        self.rows = gridItems
        self.spacing = spacing
        self.pinnedViews = pinnedViews
        self.content = viewBuilder()
        verticalAlignment = alignment.vertical
        horizontalAlignment = alignment.horizontal
        updateOrientation()
    }
    
    public init(isReverse: Bool = false, columns: [GridItem], rows: [GridItem], alignment: Alignment = .center, spacing: CGFloat? = nil, pinnedViews: PinnedScrollableViews = .init(), @ViewBuilder viewBuilder: @escaping () -> C = { EmptyView() }) {
        self.isReverse = isReverse
        self.columns = columns
        self.rows = rows
        self.spacing = spacing
        self.pinnedViews = pinnedViews
        self.content = viewBuilder()
        verticalAlignment = alignment.vertical
        horizontalAlignment = alignment.horizontal
        updateOrientation()
    }
    
    public var body: some View {
        ZStack {
            if isVertical {
                LazyVGrid(columns: columns, alignment: horizontalAlignment, spacing: spacing, pinnedViews: pinnedViews) {
                    content
                }
            } else {
                LazyHGrid(rows: rows, alignment: verticalAlignment, spacing: spacing, pinnedViews: pinnedViews) {
                    content
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            updateOrientation()
        }
    }
    
    private func updateOrientation() {
        switch UIDevice.current.orientation {
        case .portrait:
            isVertical = !isReverse
        case .landscapeRight, .landscapeLeft:
            isVertical = isReverse
        default:
            break
        }
    }
}

struct OALazyGridView_Previews: PreviewProvider {
    static var previews: some View {
        OALazyGridView(gridItems: []) {
            Text("1")
            Text("2")
        }
    }
}
