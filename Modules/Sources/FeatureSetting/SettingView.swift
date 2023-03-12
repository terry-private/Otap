//
//  SettingView.swift
//  
//
//  Created by 若江照仁 on 2023/03/12.
//

import SwiftUI
import Extensions
import Utility

public struct SettingView<SoundEffect: SoundEffectUseCase>: View {
    public init() {}
    public var body: some View {
        Form {
            Section {
                HStack {
                    Text("効果音")
                    Spacer()
                    Slider(value: .init(
                        get: { SoundEffect.effectVolume },
                        set: { SoundEffect.effectVolume = $0 }
                    ))
                    .frame(width: 150)
                }
                HStack {
                    Text("読み上げ音声")
                    Spacer()
                    Slider(value: .init(
                        get: { SoundEffect.utteranceVolume },
                        set: { SoundEffect.utteranceVolume = $0 }
                    ))
                        .frame(width: 150)
                }
            }
            Section {
                HStack {
                    Text("バージョン")
                    Spacer()
                    Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")
                }
                HStack {
                    Text("ライセンス情報")
                    Spacer()
                    Text(UIDevice.current.name)
                }
            }
        }
        .navigationBarTitle("設定")
    }
}

#if DEBUG
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView<SoundEffectUseCaseDummy>()
    }
}
#endif
