//
//  MainVM.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 3.02.23.
//



import Foundation
import CoreLocation

final class MainVM: MainVMProtocol {
    
    var networkService: NetworkService?
    var WeatherModel: WeatherResponse?
    
    var contentDidUpdate: (() -> Void)?
    
    let locationService = LocationService()

    var addres: String?
    var currentLocation : CLLocation?
    
    func loadData() {
//        self.locationService.delegate = self // Set self as delegate
        self.locationService.startUpdatingLocation()  // Requests start updating location
        didUpdateLocation()
        
    }
    
    init() {
        self.locationService.delegate = self // Set self as delegate
        self.locationService.startUpdatingLocation()  // Requests start updating location
    }
//    func didUpdateLocation() {
//        getWeatherForCurrentLocation()
//    }
    
//    func getWeatherForCurrentLocation() {
//           if let currentLocation = locationService.getCurrentLocation() {
//               self.currentLocation = currentLocation
//               let long = currentLocation.coordinate.longitude
//               let lat = currentLocation.coordinate.latitude
//               let location = CLLocation(latitude: lat, longitude: long)
//               location.placemark { placemark, error in
//                   guard let placemark = placemark else {
//                       print("Error:", error ?? "nil")
//                       return
//                   }
//                   self.addres = placemark.locality ?? ""
//
//                   self.networkService?.sendRequest(lat: lat, long: long) { [weak self] loadModel in
//                       self?.WeatherModel = loadModel
//                       DispatchQueue.main.async {
//                           self?.contentDidUpdate?()
//                       }
//                   }
//               }
//           }else {print("Error")}
//       }
}


extension MainVM: LocationServiceDelegate {


    func didUpdateLocation() {
        getWeatherForCurrentLocation()
    }

    func getWeatherForCurrentLocation() {
        if let currentLocation = locationService.getCurrentLocation() {
            self.currentLocation = currentLocation
            let long = currentLocation.coordinate.longitude
            let lat = currentLocation.coordinate.latitude
            let location = CLLocation(latitude: lat, longitude: long)
            location.placemark { placemark, error in
                guard let placemark = placemark else {
                    print("Error:", error ?? "nil")
                    return
                }
                self.addres = placemark.locality ?? ""

                self.networkService?.sendRequest(lat: lat, long: long) { [weak self] loadModel in
                    self?.WeatherModel = loadModel
                    DispatchQueue.main.async {
                        self?.contentDidUpdate?()
                    }
                }
            }
        }else {print("Error")}
    }
    
//    init(with delegate: WeatherViewDelegate) {
//        self.delegate = delegate
//        self.locationService.delegate = self // Set self as delegate
//        self.locationService.startUpdatingLocation()  // Requests start updating location
//    }
    
}



