//
//  FavoriteViewController.swift
//  WeatherApp
//
//  Created by Lilia Yudina on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence

class FavoriteViewController: UIViewController {

    private let favoriteView = FavoriteView()
    public let dataPersistance = DataPersistence<Pictures>(filename: "pictures.plist")
    
    override func loadView() {
        view = favoriteView
    }
    
    private var pictures = [Pictures]() {
          didSet {
              DispatchQueue.main.async {
                self.favoriteView.collectionView.reloadData()
              }
          }
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteView.collectionView.dataSource = self
        favoriteView.collectionView.delegate = self
        
            favoriteView.collectionView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellWithReuseIdentifier: "favoriteCell")

    }
    override func viewWillAppear(_ animated: Bool) {
        loadPictures()
    }
    
    func loadPictures() {
        do {
            pictures = try dataPersistance.loadItems().reversed()
        } catch {
            
        }
    }

}

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictures.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? FavoriteCell else {
                   fatalError("could not downcast to FavoriteCell")
               }
               let picture = pictures[indexPath.row]
        cell.configureCell(for: picture)
        return cell
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let maxSize: CGSize = UIScreen.main.bounds.size
           let itemWidth: CGFloat = maxSize.width * 0.95
           return CGSize(width: itemWidth, height: 250)
       }
}
