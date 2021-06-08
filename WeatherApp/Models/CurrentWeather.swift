//
//  Weather.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 11.05.2021.
//

import Foundation

struct CurrentWeather: Codable {
    let main: Main
    let name: String
    let weather: [Weather]
    let dt: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case weatherDescription = "description"
        case icon
    }
}

struct Main: Codable {
    let temp: Double
}

