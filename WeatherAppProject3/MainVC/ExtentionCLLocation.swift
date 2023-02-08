//
//  ExtentionCLLocation.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 3.02.23.
//

import Foundation
import CoreLocation

extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}
