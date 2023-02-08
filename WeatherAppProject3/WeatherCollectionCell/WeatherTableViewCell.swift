//
//  WeatherTableViewCell.swift
//  WeatherAppProject3
//
//  Created by George Popkich on 26.01.23.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var hightTempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var iconWeather: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    
    func configure(whith model: CurrentConditions) {
        guard let tempmax = model.tempmax, let tempmin = model.tempmin else {return}
        let tempmaxString = String(format: "%.0f",tempmax) + "°"
        let tempminString = String(format: "%.0f", tempmin) + "°"
        let date = model.datetime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let dayName = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "EE"
            let dayNameString = dateFormatter.string(from: dayName)
            if date == currentDate() {
                self.dayLabel.text = "Today"
            }else {
                self.dayLabel.text = "\(dayNameString)"
            }
            
        } else {
            print("String is not in format \(dateFormatter.dateFormat ?? "")")
        }
        self.hightTempLabel.text = tempmaxString
        self.lowTempLabel.text = tempminString
        let image = UIImage(named: "\(model.icon)")
        self.iconWeather.image = image
    }
    
    func currentDate() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let formatteddate = dateFormatter.string(from: date as Date)
        
        return formatteddate
        
    }
}
