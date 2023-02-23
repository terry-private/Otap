//
//  SwiftUIView.swift
//  
//
//  Created by 若江照仁 on 2023/02/06.
//

import SwiftUI
import Extensions

public struct SquareGrid<Element: Identifiable, V: View>: View {
    let elements: [Element]
    let content: (Element) -> V
    let spacing: CGFloat
    let globalNamespace: Namespace.ID?
    @State private var size: CGSize = .zero
    @Namespace var localNamespace
    
    public init(_ elements: [Element], spacing: CGFloat = 8, globalNamespace: Namespace.ID? = nil , @ViewBuilder content: @escaping (Element) -> V) {
        self.elements = elements
        self.content = content
        self.spacing = spacing
        self.globalNamespace = globalNamespace
    }
    
    public var body: some View {
        Color.clear
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChangeFrame { size = $0 }
            .overlay {
                switch elements.count {
                case 1:
                    cell(elements[0])
                case 2, 4, 6:
                    grid(columnsCount: 2)
                case 3:
                    VStack(spacing: spacing) {
                        cell(elements[0])
                        row(1, 2)
                    }
                case 5:
                    VStack(spacing: spacing) {
                        row(0, 1)
                        cell(elements[2])
                        row(3, 4)
                    }
                case 7:
                    VStack(spacing: spacing) {
                        row(0, 1)
                        row(2, 3, 4)
                        row(5, 6)
                    }
                case 8:
                    VStack(spacing: spacing) {
                        row(0, 1, 2)
                        row(3, 4)
                        row(5, 6, 7)
                    }
                case 9, 12:
                    grid(columnsCount: 3)
                case 10:
                    VStack(spacing: spacing) {
                        row(0, 1)
                        row(2, 3, 4)
                        row(5, 6, 7)
                        row(8, 9)
                    }
                case 11:
                    HStack(spacing: spacing) {
                        column(0, 1, 2, 3)
                        column(4, 5, 6)
                        column(7, 8, 9, 10)
                    }
                case 13:
                    VStack(spacing: spacing) {
                        row(0, 1, 2, 3)
                        HStack(spacing: centeringSpace) {
                            column(4, 5)
                            cell(elements[6])
                            column(7, 8)
                        }
                        row(9, 10, 11, 12)
                    }
                case 14:
                    HStack(spacing: spacing) {
                        column(0, 1, 2, 3)
                        column(4, 5, 6)
                        column(7, 8, 9)
                        column(10, 11, 12, 13)
                    }
                case 15:
                    VStack(spacing: spacing) {
                        row(0, 1, 2)
                        row(3, 4, 5, 6)
                        row(7, 8, 9, 10)
                        row(11, 12, 13, 14)
                    }
                case 16:
                    grid(columnsCount: 4)
                default:
                    grid(columnsCount: 4)
                }
            }
    }
    
    // MARK: layout methods
    private func row(_ indices: Int ..., isLargeSpace: Bool = false) -> some View {
        HStack(spacing: isLargeSpace ? centeringSpace : spacing) {
            ForEach(indices.map { elements[$0] }) { element in
                cell(element)
            }
        }
    }
    
    private func column(_ indices: Int ..., isLargeSpace: Bool = false) -> some View {
        VStack(spacing: isLargeSpace ? centeringSpace : spacing) {
            ForEach(indices.map { elements[$0] }) { element in
                cell(element)
            }
        }
    }
    
    private func grid(columnsCount: Int) -> some View{
        LazyVGrid(columns: .init(repeating: .init(.fixed(length), spacing: spacing), count: columnsCount), spacing: spacing) {
            ForEach(elements) { element in
                cell(element)
            }
        }
    }
    
    private func cell(_ element: Element) -> some View {
        let length = length
        return content(element)
            .frame(width: abs(length), height: abs(length))
            .cornerRadius(length / 10)
            .matchedGeometryEffect(id: element.id, in: globalNamespace ?? localNamespace)
            .shadow(color: .black.opacity(0.2), radius: length / 10)
    }
    
    // MARK: size calculator methods
    private var centeringSpace: CGFloat {
        spacing*3/2 + length/2
    }
    
    private var length: CGFloat {
        func calc(hCount: Int, vCount: Int) -> CGFloat {
            min(
                (size.width - spacing * CGFloat(hCount + 1)) / CGFloat(hCount),
                (size.height - spacing * CGFloat(vCount + 1)) / CGFloat(vCount),
                250
            )
        }
        switch elements.count {
        case 0 ... 4:
            return calc(hCount: 2, vCount: 2)
        case 5 ... 6:
            return calc(hCount: 2, vCount: 3)
        case 7 ... 9:
            return calc(hCount: 3, vCount: 3)
        case 10 ... 12:
            return calc(hCount: 3, vCount: 4)
        default:
            return calc(hCount: 4, vCount: 4)
        }
    }
}

struct SquareGrid_Previews: PreviewProvider {
    struct Tap: Identifiable {
        let id: UUID = UUID()
        static func array(_ count: Int) -> [Self] {
            (0..<count).map { _ in .init() }
        }
    }
    static var previews: some View {
        VStack {
            Text("test")
            SquareGrid(Tap.array(9)) { tap in
                Rectangle()
            }
            .clipped()
        }
    }
}
