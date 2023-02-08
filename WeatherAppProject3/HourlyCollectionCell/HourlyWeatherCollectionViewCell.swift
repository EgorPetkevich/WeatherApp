//
//  HourlyWeatherCollectionViewCell.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 27.01.23.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet var iconWeather: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    var timeSunrise: String?
    var timeSunset: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var indentifier = "HourlyWeatherCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "HourlyWeatherCollectionViewCell", bundle: nil)
    }
    
    
    func configure(whith model: CurrentConditions) {
        
     
        let temp = String(format: "%.0f", model.temp) + "°"
        let date = model.datetime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH-mm-ss"
        if let time = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "HH"
            let dayNameString = dateFormatter.string(from: time)
            if dayNameString == currentTime() {
                self.timeLabel.text = "Now"
            }else {
                self.timeLabel.text = "\(dayNameString)"
            }
            
        }else {
            print("String is not in format \(dateFormatter.dateFormat ?? "")")
        }
        if let sunrise = model.sunrise {
            self.timeLabel.text = sunrise
        }
        if let sunset = model.sunset {
            self.timeLabel.text = sunset
        }
        self.tempLabel.text = temp
        let image = UIImage(named: "\(model.icon)")
        self.iconWeather.contentMode = .scaleAspectFit
        self.iconWeather.image = image
    }
    
    func currentTime() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let formatteddate = dateFormatter.string(from: date as Date)
        
        return formatteddate
        
    }
}
