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
    
    var locationDidUpdate: ((CurrentLocationInfo) -> Void)?
    
    let locationService = LocationService()

    var addres: String?
    var currentLocation : CLLocation?
    
    func loadData() {
        // ?
        self.locationService.delegate = self // Set self as delegate
        // ?
        self.locationService.startUpdatingLocation()  // Requests start updating location
        didUpdateLocation()
        
    }
    


}


extension MainVM: LocationServiceDelegate {


    func didUpdateLocation() {
        getWeatherForCurrentLocation()
    }

    func getWeatherForCurrentLocation() {
        
        //MARK: closure func getCurrentLocation
        //        locationService.getCurrentLocation(complition: { currentLocationInfo, location in
        //            location.placemark { placemark, error in
        //                guard let placemark = placemark else {
        //                    print("Error:", error ?? "nil")
        //                    return
        //                }
        //                self.addres = placemark.locality ?? ""
        //
        //                self.networkService?.sendRequest(lat: currentLocationInfo.lat, long: currentLocationInfo.long) { [weak self] loadModel in
        //                    self?.WeatherModel = loadModel
        //                    DispatchQueue.main.async {
        //                        self?.contentDidUpdate?()
        //                    }
        //                }
        //            }
        //        })
        
        //MARK: stored currentLocation = nil
        if let currentLocation = locationService.currentLocation {
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



