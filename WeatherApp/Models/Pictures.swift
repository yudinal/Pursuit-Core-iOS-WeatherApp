//
//  Pictures.swift
//  WeatherApp
//
//  Created by Lilia Yudina on 2/3/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct PictureSearch: Codable {
    let hits: [Pictures]
}

struct Pictures: Codable & Equatable {
    let id: Int
    let largeImageURL: String
    let tags: String
    let comments: Int
    let views: Int
    let likes: Int
    let downloads: Int
    let previewURL: String
}
