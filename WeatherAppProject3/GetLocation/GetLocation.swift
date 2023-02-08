//
//  GetLocation.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 30.01.23.
//

//import Foundation
//import CoreLocation
////MARK: GetLocation
//extension MainVC: CLLocationManagerDelegate {
//    
//    func setupLocation() {
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if !locations.isEmpty, currentLocation == nil {
//            currentLocation = locations.first
//            locationManager.stopUpdatingLocation()
//            requestWeatherForLocation()
//            
//            
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print()
//    }
//    
//    func requestWeatherForLocation() {
//        guard let currentLocation = currentLocation else {return}
//        let long = currentLocation.coordinate.longitude
//        let lat = currentLocation.coordinate.latitude
//        networkService.sendRequest(lat: lat, long: long, complition: { model in
//            guard let model = model else {print("Error")
//                return }
//            self.weatherResponse = model
//            self.currentWeather = model.currentConditions
//            self.dailyModels.append(contentsOf: model.days)
////            self.houryModels.append(contentsOf: model.currentConditions.hours!)
//            self.houryModels.append(contentsOf: model.days[0].hours!)
//            
//            DispatchQueue.main.async {
//                self.navigationBarSetup()
////                self.navigationController?.navigationBar.view = self.createCollecionHeaderView()
//                self.collectionView.reloadData()
//                print("self.dailyModels.count")
//
//                
//            }
//        })
//        
//        let location = CLLocation(latitude: lat, longitude: long)
//        location.placemark { placemark, error in
//            guard let placemark = placemark else {
//                print("Error:", error ?? "nil")
//                return
//            }
//            self.addres = placemark.locality ?? ""
//            print(placemark.locality ?? "")
//        }
//        
//        
//    }
//    
//}
//
//extension CLLocation {
//    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
//        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
//    }
//}
