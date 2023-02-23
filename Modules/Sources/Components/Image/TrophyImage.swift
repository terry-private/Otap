//
//  TrophyImage.swift
//  
//
//  Created by 若江照仁 on 2023/02/22.
//

import SwiftUI

public struct TrophyImage: View {
    public init() {}
    public var body: some View {
        Image("trophy", bundle: .module)
            .resizable()
    }
}

struct TrophyImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TrophyImage()
            TrophyImage()
                .frame(width: 100, height: 100)
            TrophyImage()
                .frame(width: 30, height: 30)
        }
    }
}
