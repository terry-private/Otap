//
//  MainTab.swift
//  
//
//  Created by 若江照仁 on 2023/03/12.
//

import SwiftUI
import Drills
import Extensions
import FeatureMainTab
import FeatureSelectDrill
import FeatureSetting
import RepositoryImpl
import Utility

public enum MainTabViewFactoryImpl: MainTabViewFactoryProtocol {
    @MainActor
    public static var selectDrillView: AnyView {
        SelectDrillView<SelectDrillViewFactoryImpl, SelectDrillViewModelImpl>(
            viewModel: .init(
                selectors: [
                    ShapeDrillLevelSelector.basic1,
                    ColorDrillLevelSelector.basic1,
                    FunnyAnimalDrillLevelSelector.basic1,
                    CreatureDrillLevelSelector.advanced1,
                    FruitsAndVegetablesDrillLevelSelector.fruit1,
                    VehicleDrillLevelSelector.basic1,
                    NationalFlagDrillLevelSelector.asia1,
                    NumberDrillLevelSelector.dice123,
                    HiraganaDrillLevelSelector.あ行
                ]
            )
        )
        .toAnyView()
    }
    
    @MainActor
    public static var settingView: AnyView {
        SettingView<RepositoryImpl, SoundEffectInteractor<RepositoryImpl>>()
            .toAnyView()
    }
}

