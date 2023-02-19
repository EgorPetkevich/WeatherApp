//
//  MainVM.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 3.02.23.
//



import Foundation
import CoreLocation

final class MainVM: MainVMProtocol {
    
    
    var WeatherModel: WeatherResponse?
    
    var contentDidUpdate: (() -> Void)?
    
    let locationService = LocationService()

    var addres: String?
    var currentLocation : CLLocation?
    
    func loadData() {
        self.locationService.delegate = self // Set self as delegate
        // Requests start/stop updating location
        self.locationService.startUpdatingLocation()
        
    }
}
extension MainVM: NetworkServiceProtocol {
    var networkService: NetworkService {
        let networkService = NetworkService()
        return networkService
    }
    
    
}


extension MainVM: LocationServiceDelegate {


    func didUpdateLocation(currentLocation: CLLocation) {
        self.currentLocation = currentLocation
        self.locationService.stopUpdatingLocation()
        getWeatherForCurrentLocation()
    }

    func getWeatherForCurrentLocation() {
        
        let location = currentLocation!
        location.placemark { placemark, error in
            guard let placemark = placemark else {
                print("Error:", error ?? "nil")
                return
            }
            self.addres = placemark.locality ?? ""
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            self.networkService.sendRequest(lat: lat, long: long) { [weak self] loadModel in
                self?.WeatherModel = loadModel
                DispatchQueue.main.async {
                    self?.contentDidUpdate?()
                }
            }
        }
    }

}



