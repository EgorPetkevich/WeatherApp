//
//  LocationManagerProtocol.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 3.02.23.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    var locationManager: CLLocationManager? {get}
    var currentLocation: CLLocation? {get}
    func setupLocation()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    func requestWeatherForLocation()
}
