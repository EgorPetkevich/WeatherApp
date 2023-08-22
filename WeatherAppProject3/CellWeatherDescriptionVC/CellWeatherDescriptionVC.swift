//
//  CellWeatherDescriptionVC.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 14.02.23.
//

import UIKit







class CellWeatherDescriptionVC: UIViewController {

   
    static var indetifire = "CellWeatherDescriptionVC"
    
    static func nib() -> UINib {
        return UINib(nibName: "CellWeatherDescriptionVC", bundle: nil)
    }

    @IBOutlet private var collectionWetherInfo: UICollectionView!
    @IBOutlet private var timeFromCellLabel: UILabel!
    
    
    var cellWeatherDescriptionVM: CellWeatherDescriptionVMProtocol
  
    init(cellWeatherDescriptionVM: CellWeatherDescriptionVMProtocol){
        self.cellWeatherDescriptionVM = cellWeatherDescriptionVM
        super.init(nibName: "\(CellWeatherDescriptionVC.self)", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
          super.viewDidLoad()
        setupCollectionView()
        bind()
        registerCell()
        setup()
          
          // Do any additional setup after loading the view.
      }
    
    private func bind() {
        self.cellWeatherDescriptionVM.contentDidUpdate = {self.collectionWetherInfo?.reloadData()}
    }
    
    private func setup() {
        guard let date = cellWeatherDescriptionVM.WeatherModel?.datetime else {return}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let time = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "dd-MMMM"
            let dayNameString = dateFormatter.string(from: time)
            self.timeFromCellLabel.text =  "\(dayNameString)"
        }
        dateFormatter.dateFormat = "HH-mm-ss"
        if let time = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "HH"
            let dayNameString = dateFormatter.string(from: time)
            self.timeFromCellLabel.text =  "\(dayNameString) hours"
        }
        
        
        
    }
    
    
    private func registerCell() {
        collectionWetherInfo?.register(DescriptionCell.nib(), forCellWithReuseIdentifier: DescriptionCell.indentifire)
    }
    
}


extension CellWeatherDescriptionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView () {
        collectionWetherInfo.delegate = self
        collectionWetherInfo.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionWetherInfo {
        case self.collectionWetherInfo:
            return 2
        default: return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionWetherInfo {
        case self.collectionWetherInfo:
            if section == 0 || section == 1 {
                return 2
            }else {
                return 0
            }
        default: return 0
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
                let info = cellWeatherDescriptionVM.WeatherModel?.windspeed ?? 0
                return collectionView.CreatedescriptionCell(indexPath: indexPath, info: info, description: "windspeed", si: si.windspeed.rawValue)
            }
            if indexPath.row == 1{
                
                let info = cellWeatherDescriptionVM.WeatherModel?.pressure ?? 0.0
               
                return collectionView.CreatedescriptionCell(indexPath: indexPath, info: info, description: "pressure", si: si.pressure.rawValue)
            }
            
        }
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                let info = cellWeatherDescriptionVM.WeatherModel?.feelslike ?? 0
                return collectionView.CreatedescriptionCell(indexPath: indexPath, info: info, description: "feelslike", si: si.temp.rawValue)
            }
            if indexPath.row == 1 {
                let info = cellWeatherDescriptionVM.WeatherModel?.icon ?? ""
                return collectionView.CreatedescriptionCell(indexPath: indexPath, info: "", description: info, si: nil)
            }
        }
        
        
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.size.width / 2 - 20, height: 250)
    }
    
    
    
    @IBAction private func crossButtonDidTap() {
        self.dismiss(animated: true)
    }
    
}


