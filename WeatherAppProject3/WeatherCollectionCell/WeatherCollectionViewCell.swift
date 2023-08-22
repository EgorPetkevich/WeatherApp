//
//  WeatherCollectionViewCell.swift
//  WeatherAppProject3
//
//  Created by George Popkich on 26.01.23.
//

import UIKit

import UIKit



class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet var tableView: UITableView!
    var model = [CurrentConditions]()
    
    func mainVC() -> UIViewController {
        return UIViewController(nibName: MainVC.indentifire, bundle: nil)
        
    }
    
    weak  var cellDelegate: WeatherCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.borderColor = UIColor.separator.cgColor
        self.contentView.layer.masksToBounds = true
        registerCells()
        sendTableViewData()
        
        
        
    }


    
    static let identifier = "WeatherCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
    }
    
    private func registerCells() {
        self.tableView.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
    }
    
    
    func configure(whith model: [CurrentConditions]) {
        self.model = model
       
        self.tableView.reloadData()
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}


extension WeatherCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func sendTableViewData() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let WeatherCell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell {

            WeatherCell.configure(whith: model[indexPath.row])

            return WeatherCell
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { 
       
        cellDelegate?.collectionView(collectioncell: self, index: indexPath.row, didTappedInTableViewCell: tableView.cellForRow(at: indexPath) ?? UITableViewCell())
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}




    
    

