//
//  Forecast.swift
//  WeatherApp
//
//  Created by Lilia Yudina on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    
    let latitude: Double
    let longitude: Double
    let timezone: String
    let daily: DailyForecast
}

struct DailyForecast: Codable {
    let summary: String
    let icon: String
    let data: [Information]
}

struct Information: Codable {
        let time: Double
        let summary: String
        let icon: String
        let sunriseTime: Double
        let sunsetTime: Double
        let moonPhase: Double
        let precipIntensity: Double
        let precipIntensityMax: Double
        let precipIntensityMaxTime: Double
        let precipProbability: Double
        let precipType: String
        let temperatureHigh: Double
        let temperatureHighTime: Double
        let temperatureLow: Double
        let temperatureLowTime: Double
        let apparentTemperatureHigh: Double
        let apparentTemperatureHighTime: Double
        let apparentTemperatureLow: Double
        let apparentTemperatureLowTime: Double
        let dewPoint: Double
        let humidity: Double
        let pressure: Double
        let windSpeed: Double
        let windGust: Double
        let windGustTime: Double
        let windBearing: Double
        let cloudCover: Double
        let uvIndex: Double
        let uvIndexTime: Double
        let visibility: Double
        let ozone: Double
        let temperatureMin: Double
        let temperatureMinTime: Double
        let temperatureMax: Double
        let temperatureMaxTime: Double
        let apparentTemperatureMin: Double
        let apparentTemperatureMinTime: Double
        let apparentTemperatureMax: Double
        let apparentTemperatureMaxTime: Double
    }

extension Double {
    func timeConverter() -> String {
            let date = Date(timeIntervalSince1970: self)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            return localDate
        }
}
