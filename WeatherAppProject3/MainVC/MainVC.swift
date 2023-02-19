//
//  ViewController.swift
//  WeatherAppProject
//
//  Created by George Popkich on 9.01.23.
//

import UIKit
import CoreLocation


import Foundation


class MainVC: UIViewController, WeatherCollectionViewCellDelegate, HourlyCollectionViewCellDelegate {
    func collectionView(collectioncell: UICollectionViewCell?, index: Int, didTappedInCollectionViewCell: UICollectionViewCell) {
        let model = mainViewModel.WeatherModel?.days[0].hours ?? []
        let presentVC = CellWeatherDescriptionConfigurator.makeVC(model: model[index])
        self.present(presentVC, animated: true)
    }
    
    
    func collectionView(collectioncell: UICollectionViewCell?, index: Int, didTappedInTableViewCell: UITableViewCell) {
        let model = mainViewModel.WeatherModel?.days ?? []
        let presentVC = CellWeatherDescriptionConfigurator.makeVC(model: model[index])
        self.present(presentVC, animated: true)
    }
    
    
    
    
    var cellTableView: WeatherCollectionViewCellDelegate?
    
    
    static var indentifire = "MainVC"
    
    static func nib() -> UINib{
        return UINib(nibName: "MainVC", bundle: nil)
    }
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    var mainViewModel: MainVMProtocol
    
    
    init(mainViewModel: MainVMProtocol) {
        self.mainViewModel = mainViewModel
        super.init(nibName: "\(MainVC.self)", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        registerCells()
        
        mainViewModel.loadData()
        setupCollectionView()
        
        
        
    }
    private func bind() {
        self.mainViewModel.contentDidUpdate = {self.collectionView.reloadData()}
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
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.allowsSelection = true
        self.collectionView.allowsMultipleSelection = true
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
            currentWeatherCell.configure(whith: mainViewModel.WeatherModel?.currentConditions, addres: mainViewModel.addres)
            
            return currentWeatherCell
        }
        
        
        if indexPath.section == 1 {
            guard let HourlyWeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HourlyCollectionViewCell.self)", for: indexPath) as? HourlyCollectionViewCell else {return cell}
            
            //            HourlyWeatherCell.configure(whith: houryModels)
            
            HourlyWeatherCell.configure(whith: mainViewModel.WeatherModel?.days[0].hours ?? [])
            
            
            return HourlyWeatherCell
        }
        
        if indexPath.section == 2 {
            guard let WeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(WeatherCollectionViewCell.self)", for: indexPath) as? WeatherCollectionViewCell else {return cell}
            
            WeatherCell.cellDelegate = self
            
            //            WeatherCell.configure(whith: dailyModels)
            WeatherCell.configure(whith: mainViewModel.WeatherModel?.days ?? [])
            
            return WeatherCell
        }
        
        
        
        
        return cell
    }
    
}




