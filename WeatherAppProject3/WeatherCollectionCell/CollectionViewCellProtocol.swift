//
//  CollectionViewCellDelegateProtocol.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 19.02.23.
//

import UIKit


protocol WeatherCollectionViewCellDelegate: AnyObject {
    func collectionView(collectioncell: UICollectionViewCell?, index: Int, didTappedInTableViewCell: UITableViewCell)
}
