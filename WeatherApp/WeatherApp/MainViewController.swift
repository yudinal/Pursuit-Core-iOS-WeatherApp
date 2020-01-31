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
    
    
let zipCode = "10023"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = forecastView
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        
        forecastView.collectionView.dataSource = self
        forecastView.collectionView.delegate = self
        
        forecastView.collectionView.register(UINib(nibName: "ForecastCell", bundle: nil), forCellWithReuseIdentifier: "forecastCell")

        
     userInput(zipCode: zipCode)
    }

    
    func userInput(zipCode: String) {
        ZipCodeHelper.getLatLong(fromZipCode: zipCode) { [weak self] (result) in
               switch result {
               case .success(let latLong):
                self?.forecastView.areaNameLabel.text = "Weather Forcast for \(latLong.placeName)"
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
        cell.backgroundColor = .white
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let maxSize: CGSize = UIScreen.main.bounds.size
    let itemWidth: CGFloat = maxSize.width * 0.95
    return CGSize(width: itemWidth, height: 250)
}

}
