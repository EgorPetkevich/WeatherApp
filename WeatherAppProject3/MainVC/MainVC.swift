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
        collectionView.register(DescriptionCell.nib(), forCellWithReuseIdentifier: DescriptionCell.indentifire)
    }
    
   
    
    
}

extension MainVC: WeatherCollectionViewCellDelegate {
    
}

extension MainVC: HourlyCollectionViewCellDelegate {
    
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
                return CGSize(width: view.bounds.width - 40 , height: 570)
            }
            
            if indexPath.section == 3 || indexPath.section == 4 {
                return CGSize(width: view.bounds.size.width / 2 - 25, height: 250)
                
            }else {return CGSize()}
            
        default: return CGSize()
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case self.collectionView:
            return 5
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.collectionView :
            if section == 0 || section == 1 || section == 2 {
                return 1
            }
            if section == 3 {return 2}
            if section == 4 {return 2}
            
            return 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        
        if indexPath.section == 0 {
            guard let currentWeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCollectionViewCell.identifire, for: indexPath) as? CurrentWeatherCollectionViewCell else {return cell}
            currentWeatherCell.configure(whith: mainViewModel.WeatherModel?.currentConditions, addres: mainViewModel.addres)
            
            return currentWeatherCell
        }
        
        
        if indexPath.section == 1 {
            
            guard let hourlyWeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as? HourlyCollectionViewCell else {return cell}
            
            hourlyWeatherCell.cellDelegate = self
            hourlyWeatherCell.configure(whith: mainViewModel.WeatherModel?.days[0].hours ?? [])
            
            
            return hourlyWeatherCell
        }
        
        if indexPath.section == 2 {
            guard let weatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else {return cell}
            
            weatherCell.cellDelegate = self
            weatherCell.configure(whith: mainViewModel.WeatherModel?.days ?? [])
            
            return weatherCell
        }
        
        if indexPath.section == 3 {
            if indexPath.row == 0 {
                
                let info = mainViewModel.WeatherModel?.currentConditions.windspeed ?? 0
                return collectionView.CreatedescriptionCell(indexPath: indexPath, info: info, description: "windspeed", si: si.windspeed.rawValue)
            }
            if indexPath.row == 1{
                
                let info = mainViewModel.WeatherModel?.currentConditions.pressure ?? 0.0
                
                return collectionView.CreatedescriptionCell(indexPath: indexPath, info: info, description: "pressure", si: si.pressure.rawValue)
            }
            
        }
        if indexPath.section == 4 {
            if indexPath.row == 0 {
                let info = mainViewModel.WeatherModel?.currentConditions.feelslike ?? 0
                return collectionView.CreatedescriptionCell(indexPath: indexPath, info: info, description: "feelslike", si: si.temp.rawValue)
            }
            if indexPath.row == 1 {
                let info = mainViewModel.WeatherModel?.currentConditions.icon ?? ""
                return collectionView.CreatedescriptionCell(indexPath: indexPath, info: "", description: info, si: nil)
            }
        }
        
        
        
        return cell
    }
    
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 || section == 2 {
            return UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        }
        
        if section == 3 || section == 4 {
            return UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        }
        return UIEdgeInsets()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if section == 3 || section == 4 {
            return 20.0
        }
        return CGFloat()
    }

    
    
}




