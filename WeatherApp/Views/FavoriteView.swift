//
//  FavoriteView.swift
//  WeatherApp
//
//  Created by Lilia Yudina on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoriteView: UIView {

   public lazy var collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         layout.itemSize = CGSize(width: 150, height: 150)
         let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
         cv.backgroundColor = .systemBackground
         return cv
     }()
    
    override init(frame: CGRect) {
      super.init(frame: UIScreen.main.bounds)
      commonInit()
    }
    
    required init?(coder: NSCoder) {
      super.init(coder: coder)
      commonInit()
    }
    
    private func commonInit() {
        setupCollectionViewConstraints()
    }

    private func setupCollectionViewConstraints() {
            addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                collectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 1),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
            
        }
}
