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

typealias CurrentLocationInfo = (lat: CLLocationDegrees, long: CLLocationDegrees)

class LocationService: NSObject, CLLocationManagerDelegate {
    
    // ?
    weak var delegate: LocationServiceDelegate?
    // ?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

        }
    
    
    func getCurrentLocation(complition : @escaping (CurrentLocationInfo, CLLocation) -> Void) -> CLLocation? {
        // how can I catch a location?
        
            let lat = self.currentLocation!.coordinate.latitude
            let long = self.currentLocation!.coordinate.longitude
            let currentLocationInfo: CurrentLocationInfo = (lat, long)
            complition(currentLocationInfo, self.currentLocation!)
        
        return currentLocation
    }
    
    func startUpdatingLocation() {
        // Start updating called from presenter
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation], complition : @escaping (CurrentLocationInfo, CLLocation ) -> Void ) {
        if let location = locations.last {
            currentLocation = location
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            let currentLocationInfo: CurrentLocationInfo = (lat, long)
            complition(currentLocationInfo, location)
            locationManager.stopUpdatingLocation()
            self.delegate?.didUpdateLocation()
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManagerError: \(error)")
    }
    
}


