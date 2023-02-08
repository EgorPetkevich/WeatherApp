//
//  LocationService.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 3.02.23.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: class {
    // Delegate protocol
    func didUpdateLocation()
}

class LocationService: NSObject, CLLocationManagerDelegate {
    weak var delegate: LocationServiceDelegate?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

        }
    
    
    func getCurrentLocation() -> CLLocation? {
        // how can I catch a location?
        return currentLocation
    }
    
    func startUpdatingLocation() {
        // Start updating called from presenter
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location
            locationManager.stopUpdatingLocation()
            self.delegate?.didUpdateLocation()
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManagerError: \(error)")
    }
    
}


