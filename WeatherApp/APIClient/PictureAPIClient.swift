//
//  PictureAPIClient.swift
//  WeatherApp
//
//  Created by Lilia Yudina on 2/3/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct PictureAPIClient {
    static func getPicture(placeName: String, completion: @escaping (Result<[Pictures], AppError>) -> ()) {
        let endpointURLString = "https://pixabay.com/api/?key=14991124-353bbdbf7d67c730dc6d9b550&q=\(placeName)&image_type=photo&pretty=true"
        
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
                        let searches = try JSONDecoder().decode(PictureSearch.self, from: data)
                        let pictures = searches.hits
                        completion(.success(pictures))
                    } catch {
                        completion(.failure(.decodingError(error)))
                    }
                }
            }
        
    }
}
