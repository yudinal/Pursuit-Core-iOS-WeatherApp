//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private let forecastView = ForcastsView()
    
    private var forecasts = [Information]() {
        didSet {
            DispatchQueue.main.async {
                self.forecastView.collectionView.reloadData()
            }
            
        }
    }
    public var location = ""
    
    var zipCode = "" {
        didSet {
            
        }
    }
    
    private var pictures = [Pictures]() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = forecastView
//        tabBarItem = UITabBarItem(title: "Hi", image: UIImage(named: "1.circle"), tag: 0)
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        
        forecastView.collectionView.dataSource = self
        forecastView.collectionView.delegate = self
        forecastView.textField.delegate = self
        
        forecastView.collectionView.register(UINib(nibName: "ForecastCell", bundle: nil), forCellWithReuseIdentifier: "forecastCell")
        
        
        userInput(zipCode: zipCode)
        
    }
    
    func loadPictures(_ search: String) {
        PictureAPIClient.getPicture(placeName: search) { (result) in
            switch result {
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let pictures):
                self.pictures = pictures
            }
        }
    }
    
    func userInput(zipCode: String) {
        ZipCodeHelper.getLatLong(fromZipCode: zipCode) { [weak self] (result) in
            switch result {
            case .success(let latLong):
                self?.forecastView.areaNameLabel.text = "Weather Forcast for \(latLong.placeName)"
                self?.location = latLong.placeName
                self?.loadPictures(latLong.placeName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
            
                ForecastAPIClient.getForecast(lat: latLong.lat.description, long: latLong.long.description) { (result) in
                    switch result {
                    case .success(let weatherData):
                        self!.forecasts = weatherData
                        
                    case .failure(let dataError):
                        print(dataError)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as? ForecastCell else {
            fatalError("could not downcast to ForecastCell")
        }
        let data = forecasts[indexPath.row]
        cell.dateLabel.text = data.time.timeConverter()
        cell.weatherImage.image = UIImage(named: "\(data.icon)")
        cell.highTempLabel.text = "High: \(data.temperatureHigh.description)F"
        cell.lowTempLabel.text = "Low: \(data.temperatureLow.description)F"
//        cell.backgroundColor = .white
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.95
        return CGSize(width: itemWidth, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let forecast = forecasts[indexPath.row]
        
        let detailForecastStoryboard = UIStoryboard(name: "DetailForecast", bundle: nil)
        guard let detailViewController = detailForecastStoryboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            fatalError("could not downcast to DetailViewController")
        }
        detailViewController.forecast = forecast
        detailViewController.location = location
        let randomPicture =  pictures.randomElement()
        detailViewController.picture = randomPicture
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        zipCode = text
        userInput(zipCode: zipCode)
        textField.resignFirstResponder()
        forecastView.collectionView.isHidden = false
        forecastView.defaultImage.isHidden = true
        textField.text = ""
        return true
    }
}


