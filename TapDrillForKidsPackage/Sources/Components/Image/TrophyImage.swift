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
            .renderingMode(.template)
    }
}

struct TrophyImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TrophyImage()
                .frame(width: 30, height: 30)
            TrophyImage()
                .frame(width: 60, height: 60)
            TrophyImage()
                .frame(width: 100, height: 100)
            
            TrophyImage()
                .aspectRatio(1, contentMode: .fill)
                .padding(10)
            
            TrophyImage()
                .frame(width: 100, height: 100)
            TrophyImage()
                .frame(width: 60, height: 60)
            TrophyImage()
                .frame(width: 30, height: 30)
        }
        .foregroundColor(.red)
    }
}
