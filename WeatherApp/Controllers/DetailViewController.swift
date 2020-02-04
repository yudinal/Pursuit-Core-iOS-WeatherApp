//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Lilia Yudina on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class DetailViewController: UIViewController {
    
    @IBOutlet weak var locationDateLabel: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var forecastSummaryLabel: UILabel!
    @IBOutlet weak var highTempratureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var inchesOfPrecipitationLabel: UILabel!
    
    public var forecast: Information?
    var location: String?
    var picture: Pictures?
    public let dataPersistance = DataPersistence<Pictures>(filename: "pictures.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Forecast"
        updateUI()
    }
    
    private func updateUI() {
        guard let forecast = forecast, let location = location else {
            return
        }
        locationDateLabel.text = "Weather Forecast for \(location) for \(forecast.time.timeConverter())"
        forecastSummaryLabel.text = forecast.summary
        highTempratureLabel.text = "High: \(forecast.temperatureHigh.description)F"
        lowTemperatureLabel.text = "Low: \(forecast.temperatureLow.description)F"
        sunriseLabel.text = "Sunrise: \(forecast.sunriseTime.secondTimeConverter())"
        sunsetLabel.text = "Sunset: \(forecast.sunsetTime.secondTimeConverter())"
        windSpeedLabel.text = "Wind speed: \(forecast.windSpeed.description)MPH"
        inchesOfPrecipitationLabel.text = "Inches of Precipitation: \(forecast.precipIntensityMax.description)"
        
        guard let chosenPicture = picture else {
            return
        }
        locationImage.getImage(with: picture!.largeImageURL) { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.locationImage.image = image
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        
        
        guard let picture = picture else {
            return
        }
        do {
            try dataPersistance.createItem(picture)
        } catch {
            print("could not save \(error)")
        }
        
        sender.isEnabled = false
        showAlert(title: "Save", message: "Photo has been saved!", completion: nil)
    }
}
