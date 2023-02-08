//
//  MainVMProtocol.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 3.02.23.
//

import Foundation

protocol MainVMProtocol {
    var WeatherModel: WeatherResponse? {get}
    var addres: String? {get}
    var contentDidUpdate: (() -> Void)? {get set}
    
    func loadData()
    
}
