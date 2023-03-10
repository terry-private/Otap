//
//  AppViewFactory.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import SwiftUI
import Core
import Drills
import FeatureSelectDrill

public enum AppViewFactory {
    @MainActor
    public static func selectDrillView() -> some View {
        SelectDrillView<SelectDrillViewFactoryImpl, SelectDrillViewModelImpl>(
            viewModel: .init(
                selectors: [
                    ShapeDrillLevelSelector.basic1,
                    ColorDrillLevelSelector.basic1,
                    FunnyAnimalDrillLevelSelector.basic1,
                    CreatureDrillLevelSelector.advanced1,
                    FruitsAndVegetablesDrillLevelSelector.fruit1,
                    VehicleDrillLevelSelector.basic1,
                    NumberDrillLevelSelector.dice123,
                    HiraganaDrillLevelSelector.あ行
                ]
            )
        )
    }
}
