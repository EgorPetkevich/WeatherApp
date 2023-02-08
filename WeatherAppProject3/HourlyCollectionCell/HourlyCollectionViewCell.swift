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
        registerCells()
        sendCollectionViewData()
        
    }

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
    
}
