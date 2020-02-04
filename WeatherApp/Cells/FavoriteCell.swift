//
//  FavoriteCell.swift
//  WeatherApp
//
//  Created by Lilia Yudina on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit

class FavoriteCell: UICollectionViewCell {
    
    @IBOutlet weak var favoriteImage: UIImageView!
    
    public func configureCell(for picture: Pictures) {
        favoriteImage.getImage(with: picture.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure(let image):
                self?.favoriteImage.image = UIImage(named: "")
            case .success(let image):
            DispatchQueue.main.async {
            self?.favoriteImage.image = image
            }
        }
    }
}
}
