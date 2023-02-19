//
//  CellWeatherDescriptionConfigurator.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 14.02.23.
//

import Foundation

class CellWeatherDescriptionConfigurator {
    static func makeVC(model: CurrentConditions) -> CellWeatherDescriptionVC {
        let viewModel = CellWeatherDescriptionVM(weatherModel: model)
        let vc = CellWeatherDescriptionVC(cellWeatherDescriptionVM: viewModel)
        return vc
        
    }
}
