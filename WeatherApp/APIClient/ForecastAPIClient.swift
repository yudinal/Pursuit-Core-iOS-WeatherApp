//
//  ForecastAPIClient.swift
//  WeatherApp
//
//  Created by Lilia Yudina on 1/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper


struct ForecastAPIClient {
    static func getForecast(lat: String, long: String, completion: @escaping(Result<[Information], AppError>) -> ()) {
        let endpointURLString = "https://api.darksky.net/forecast/3e3764492f7d777f573ea65c1127d2f1/\(lat),\(long)"
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searches = try JSONDecoder().decode(Forecast.self, from: data)
                    completion(.success(searches.daily.data))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
  
}
