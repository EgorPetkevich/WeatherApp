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
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
    
    
}
