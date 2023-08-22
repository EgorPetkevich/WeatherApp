//
//  ExtentionCollectionView.swift
//  WeatherAppProject4
//
//  Created by George Popkich on 28.02.23.
//


import UIKit

extension UICollectionView {
    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
}

extension UICollectionView {
    func CreatedescriptionCell<T: Any>(indexPath: IndexPath , info: T, description: String, si: String?) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        guard let descripionCell = self.dequeueReusableCell(withReuseIdentifier: DescriptionCell.indentifire, for: indexPath) as? DescriptionCell else {return cell}
     
        descripionCell.configure(description: description, info: info, si: si)
        return descripionCell
    }
}
