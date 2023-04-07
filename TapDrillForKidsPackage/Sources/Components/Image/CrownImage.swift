//
//  CrownImage.swift
//  
//
//  Created by 若江照仁 on 2023/02/23.
//

import SwiftUI

public struct CrownImage: View {
    public init() {}
    public var body: some View {
        Image("crown", bundle: .module)
            .resizable()
            .renderingMode(.template)
    }
}

struct CrownImage_Previews: PreviewProvider {
    static var previews: some View {
        CrownImage()
            .frame(width: 50, height: 40)
    }
}
