//
//  CellWeatherDescriptionVMProtocol.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 14.02.23.
//

import Foundation


protocol CellWeatherDescriptionVMProtocol {
    var WeatherModel: CurrentConditions? {get}
    var contentDidUpdate: (() -> Void)? {get set}
    
    func loadData()
    
}
