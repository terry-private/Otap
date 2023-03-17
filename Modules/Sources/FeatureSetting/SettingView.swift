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
                    Text(L10n.SettingView.SoundEffectCell.title)
                    Spacer()
                    Slider(value: .init(
                        get: { SoundEffect.effectVolume },
                        set: { SoundEffect.effectVolume = $0 }
                    ))
                    .frame(width: 150)
                }
                HStack {
                    Text(L10n.SettingView.UtteranceVoiceCell.title)
                    Spacer()
                    Slider(value: .init(
                        get: { SoundEffect.utteranceVolume },
                        set: { SoundEffect.utteranceVolume = $0 }
                    ))
                        .frame(width: 150)
                }
            }
            Section {
                NavigationLink {
                    List {
                        ForEach(License.allCases) { license in
                            NavigationLink {
                                Group {
                                    ScrollView {
                                        Text(license.text)
                                            .padding()
                                    }
                                }
                                .navigationTitle(license.rawValue)
                            } label: {
                                Text(license.rawValue)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .navigationBarTitle(L10n.LicensesView.navigationBarTitle)
                } label: {
                    Text(L10n.SettingView.LicensesCell.title)
                }
                
                HStack {
                    Text(L10n.SettingView.VersionCell.title)
                    Spacer()
                    Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")
                }
            }
        }
        .navigationBarTitle(L10n.SettingView.navigationBarTitle)
    }
}

#if DEBUG
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView<SoundEffectUseCaseDummy>()
    }
}
#endif
