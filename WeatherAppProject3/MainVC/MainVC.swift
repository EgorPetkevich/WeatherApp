//
//  ViewController.swift
//  WeatherAppProject
//
//  Created by George Popkich on 9.01.23.
//

import UIKit
import CoreLocation


import Foundation


class MainVC: UIViewController {
    
    
    var MainViewModel: MainVMProtocol = MainVM()
    
    
    
    
    
    static var indentifire = "ViewController"
    
    
    static func nib() -> UINib{
        return UINib(nibName: "ViewController", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    @IBOutlet var collectionView: UICollectionView!
    
    

   

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        registerCells()
        
        MainViewModel.loadData()
        setupCollectionView()
        
        
        
    }
    private func bind() {
        self.MainViewModel.contentDidUpdate = {self.collectionView.reloadData()}
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    
 
    
    
    
    private func registerCells() {
        collectionView.register(CurrentWeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.identifire)
        collectionView.register(WeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        collectionView.register(HourlyCollectionViewCell.nib(), forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
    }
    

}



//MARK: CollectioViewSetup
extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func setupCollectionView () {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case collectionView :
            if indexPath.section == 0 {
                return CGSize(width: view.bounds.width - 40, height: view.bounds.width - 100)
            }
            if indexPath.section == 1 {
                return CGSize(width: view.bounds.width - 40, height: 100)
            }
            if indexPath.section == 2 {
                return CGSize(width: view.bounds.width - 40 , height: 800)
            } else {return CGSize()}
            
        default: return CGSize()
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case self.collectionView:
            return 3
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.collectionView :
            if section == 0 || section == 1 || section == 2 {
                return 1
            }else {return 0}
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        
        if indexPath.section == 0 {
            guard let currentWeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCollectionViewCell.identifire, for: indexPath) as? CurrentWeatherCollectionViewCell else {return cell}
            
//            currentWeatherCell.configure(whith: currentWeather, addres: addres)
            currentWeatherCell.configure(whith: MainViewModel.WeatherModel?.currentConditions, addres: MainViewModel.addres)
            
            return currentWeatherCell
        }
        
        
        if indexPath.section == 1 {
            guard let HourlyWeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HourlyCollectionViewCell.self)", for: indexPath) as? HourlyCollectionViewCell else {return cell}
            
//            HourlyWeatherCell.configure(whith: houryModels)
            
            HourlyWeatherCell.configure(whith: MainViewModel.WeatherModel?.days[0].hours ?? [])
            
            
            return HourlyWeatherCell
        }
        
        if indexPath.section == 2 {
            guard let WeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(WeatherCollectionViewCell.self)", for: indexPath) as? WeatherCollectionViewCell else {return cell}
            
//            WeatherCell.configure(whith: dailyModels)
            WeatherCell.configure(whith: MainViewModel.WeatherModel?.days ?? [])
            
            return WeatherCell
        }
        
        
        
        
        return cell
    }
    
}




