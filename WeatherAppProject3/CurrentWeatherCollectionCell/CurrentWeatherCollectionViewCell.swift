//
//  CurrentWeatherCollectionViewCell.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 30.01.23.
//

import UIKit

final class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var view: UIView!
    
    private var tempLabel: UILabel!
    private var fillslikeTempLabel: UILabel!
    private var tempDescriptionLabel: UILabel!
    private var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    
    static var identifire = "CurrentWeatherCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CurrentWeatherCollectionViewCell", bundle: nil)
    }
    
    func configure(whith model: CurrentConditions?, addres: String?) {
        guard let model = model, let addres = addres else {return}
        self.setupCurrentTempLabels()

        locationLabel.text = "\(addres)"
        tempLabel.text = String(format: "%.0f", model.temp) + "°"
        tempLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        fillslikeTempLabel.text = "Feelslike: " + String(format: "%.0f", model.feelslike) + "°"
        tempDescriptionLabel.text = "\(model.conditions)"
        
        
    }
    
    private func setupCurrentTempLabels() {
        
            
        locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width - 20, height: view.frame.height / 5))
        tempLabel = UILabel(frame: CGRect(x: 10, y: 10 + locationLabel.frame.size.height, width: view.frame.size.width - 20, height: view.frame.height / 3))
        tempDescriptionLabel = UILabel(frame: CGRect(x: 10, y: 10 + locationLabel.frame.size.height + tempLabel.frame.size.height, width: view.frame.size.width - 20, height: view.frame.height / 5))
            
        fillslikeTempLabel = UILabel(frame: CGRect(x: 10, y: 10 + locationLabel.frame.size.height + tempLabel.frame.size.height + tempDescriptionLabel.frame.size.height, width: view.frame.size.width - 20, height: view.frame.height / 5))

            
        view.addSubview(locationLabel)
        view.addSubview(tempDescriptionLabel)
        view.addSubview(tempLabel)
        view.addSubview(fillslikeTempLabel)
 
        locationLabel.textAlignment = .center
        tempDescriptionLabel.textAlignment = .center
        tempLabel.textAlignment = .center
        fillslikeTempLabel.textAlignment = .center
        
    }
    
}



