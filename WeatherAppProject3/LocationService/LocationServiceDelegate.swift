//
//  LocationServiceDelegate.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 3.02.23.
//

import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    // Delegate protocol
    func didUpdateLocation(currentLocation: CLLocation)
  
}
