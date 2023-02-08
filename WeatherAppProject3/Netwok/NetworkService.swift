//
//  NetworkService.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 27.01.23.
//

import Foundation
import CoreLocation


final class NetworkService{

    
    func sendRequest(lat: CLLocationDegrees, long: CLLocationDegrees, complition: @escaping (WeatherResponse?) -> Void) {
        let url = URL(string: "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(lat)%2C\(long)?unitGroup=metric&elements=datetime%2Cname%2Caddress%2Ctempmax%2Ctempmin%2Ctemp%2Cfeelslike%2Csnow%2Cwindspeed%2Cpressure%2Ccloudcover%2Csunrise%2Csunset%2Cmoonphase%2Cconditions%2Cdescription%2Cicon&include=days%2Chours%2Ccurrent&key=YMCRGFFZVAH683TP2AN5C6QUV&contentType=json")!
    print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            // Convert data to models/some object
            let responseObject = try! JSONDecoder().decode(WeatherResponse.self, from: data)
           
            complition(responseObject)
            
        
        }.resume()
        
        
        
    }
    

}
