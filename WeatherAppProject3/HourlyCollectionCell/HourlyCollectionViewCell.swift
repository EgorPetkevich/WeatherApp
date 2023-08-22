//
//  HourlyCollectionViewCell.swift
//  WeatherAppProject3
//
//  Created by George Popkich on 26.01.23.
//
import UIKit
class HourlyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var collectionView: UICollectionView!

    var model = [CurrentConditions]()
   
    override func awakeFromNib() {
        
        super.awakeFromNib()
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.borderColor = UIColor.separator.cgColor
        self.contentView.layer.masksToBounds = true
        registerCells()
        sendCollectionViewData()
        
    }
    
    weak  var cellDelegate: HourlyCollectionViewCellDelegate?

    static let identifier = "HourlyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "HourlyCollectionViewCell", bundle: nil)
    }
    
    private func registerCells() {
        collectionView.register(HourlyWeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.indentifier)
        
    }
    
    func configure(whith model: [CurrentConditions]) {
        self.model = model
        collectionView.reloadData()
    }
    
    
}

extension HourlyCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func sendCollectionViewData() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.allowsSelection = true
        self.collectionView.allowsMultipleSelection = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = UICollectionViewCell()
            if let HourlyWeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.indentifier, for: indexPath) as? HourlyWeatherCollectionViewCell {
                
                HourlyWeatherCell.configure(whith: model[indexPath.row])
                
                return HourlyWeatherCell
            }
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellDelegate?.collectionView(collectioncell: self, index: indexPath.row, didTappedInCollectionViewCell: collectionView.cellForItem(at: indexPath) ?? UICollectionViewCell())
    }
    
}
