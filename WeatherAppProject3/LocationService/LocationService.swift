//
//  LocationService.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 3.02.23.
//

import Foundation
import CoreLocation


class LocationService: NSObject, CLLocationManagerDelegate {
    
 
    weak var delegate: LocationServiceDelegate?

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var count = 0
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
    }
    
    
    func startUpdatingLocation() {
        // Start updating called from presenter
        locationManager.startUpdatingLocation()
    }
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            self.delegate?.didUpdateLocation(currentLocation: location)

        }else {print("Location not  found")}
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManagerError: \(error)")
    }
    
}


