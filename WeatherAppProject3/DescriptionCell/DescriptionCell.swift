//
//  DescriptionCell.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 19.02.23.
//

import UIKit

class DescriptionCell: UICollectionViewCell {

    @IBOutlet private var cellImage: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var infoLabel: UILabel!
    
    
    static var indentifire = "DescriptionCell"
    
    static func nib() -> UINib{
          return UINib(nibName: "DescriptionCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.systemCyan.cgColor
        self.contentView.layer.masksToBounds = true
    }
    
    
    

    func configure(description: String, info: Double, si: String) {
        self.infoLabel.text = "\(info) \(si)"
        self.descriptionLabel.text = description
        self.cellImage.image = UIImage(named: "\(description)")
    }
    

}
