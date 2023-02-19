//
//  MainVCConfigurator.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 14.02.23.
//

import Foundation

final class MainVCConfigurator {
    static func makeVC() -> MainVC {
        let viewModel = MainVM()
        let vc = MainVC(mainViewModel: viewModel)
        return vc
    }
}
