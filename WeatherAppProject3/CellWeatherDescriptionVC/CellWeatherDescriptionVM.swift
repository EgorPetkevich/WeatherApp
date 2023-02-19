//
//  CellWeatherDescriptionVM.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 14.02.23.
//

import Foundation

final class CellWeatherDescriptionVM: CellWeatherDescriptionVMProtocol {
    
    var WeatherModel: CurrentConditions?
    
    var contentDidUpdate: (() -> Void)?
    
    func loadData() {
        if let _ = WeatherModel {
            contentDidUpdate?()
        }
    }
    
    init(weatherModel: CurrentConditions) {
        self.WeatherModel = weatherModel
    }
    
    
}
