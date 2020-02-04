//
//  ForcastsView.swift
//  WeatherApp
//
//  Created by Lilia Yudina on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class ForcastsView: UIView {
    
    let forecast = [Forecast]()
    
    let defaultMessage = "Enter a Zip Code"
    let areaName = "Weather Forecast for "
    
    public lazy var areaNameLabel: UILabel = {
         let label = UILabel()
         label.backgroundColor = .systemBackground
         label.textAlignment = .center
         label.text = areaName
         label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
         return label
     }()
    
   public lazy var collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         layout.itemSize = CGSize(width: 100, height: 100)
         let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
         cv.backgroundColor = .systemBackground
    cv.isHidden = true
         return cv
     }()
    
    public lazy var defaultImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "weather")
        return imageView
        
    }()
    
    public lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.backgroundColor = .lightGray
        textField.placeholder = "  Enter Zip  "
        return textField
    }()
    
    public lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.textAlignment = .center
        label.text = defaultMessage
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
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
    setupAreaNameLabelConstraints()
     setupCollectionViewConstraints()
    setupTextFieldConstaints()
    setupMessageLabelConstraints()
    setupDefaultImageConstraints()
   }
    
    private func setupAreaNameLabelConstraints() {
            addSubview(areaNameLabel)
            areaNameLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                areaNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                areaNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                areaNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
        }
     
     private func setupCollectionViewConstraints() {
         addSubview(collectionView)
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: areaNameLabel.bottomAnchor, constant: 20),
             collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
             collectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
             collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
         ])
         
     }
    private func setupDefaultImageConstraints() {
        addSubview(defaultImage)
        defaultImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            defaultImage.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            defaultImage.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            defaultImage.widthAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1),
               defaultImage.heightAnchor.constraint(equalTo: collectionView.heightAnchor, multiplier: 1),
        ])
        
    }
    private func setupTextFieldConstaints() {
        
           addSubview(textField)
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            
        
            NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20)
            ])
        }
    
    private func setupMessageLabelConstraints() {
            addSubview(messageLabel)
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                messageLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
                messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
        }

  }


