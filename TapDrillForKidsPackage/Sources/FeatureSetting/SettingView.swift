//
//  SettingView.swift
//  
//
//  Created by 若江照仁 on 2023/03/12.
//

import SwiftUI
import Core
import Extensions
import Utility

public struct SettingView<SoundEffect: SoundEffectUseCase>: View {
    @State var language: UtteranceLanguage
    public init() {
        _language = .init(wrappedValue: SoundEffect.utteranceLanguage)
    }
    public var body: some View {
        Form {
            soundConfigSection
            drillViewConfigSection
            appInfoSection
        }
        .navigationBarTitle(L10n.SettingView.navigationBarTitle)
    }
}

private extension SettingView {
    var soundConfigSection: some View {
        Section(L10n.SettingView.SoundConfig.sectionTitle) {
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
            Picker(
                L10n.SettingView.UtteranceLanguage.title,
                selection: .init(
                    get: {
                        language
                    },
                    set: {
                        SoundEffect.utteranceLanguage = $0
                        language = $0
                    }
                )
            ) {
                ForEach(UtteranceLanguage.allCases, id: \.self) {
                    Text($0.title)
                }
            }
            .pickerStyle(.menu)
        }
    }
    
    var drillViewConfigSection: some View {
        Section(L10n.SettingView.DrillViewConfig.sectionTitle) {
            NavigationLink {
                PanelPositioningView()
            } label: {
                Text(L10n.SettingView.DrillViewConfig.horizontalPaddingAdjustment)
            }
        }
    }
    
    var appInfoSection: some View {
        Section(L10n.SettingView.AppInfo.sectionTitle) {
            NavigationLink {
                LicensesView()
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
}

private extension UtteranceLanguage {
    var title: String {
        switch self {
        case .system: return L10n.SettingView.UtteranceLanguage.system
        case .english: return L10n.SettingView.UtteranceLanguage.english
        case .japanese: return L10n.SettingView.UtteranceLanguage.japanese
        }
    }
}

#if DEBUG
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView<SoundEffectUseCaseDummy>()
    }
}
#endif
