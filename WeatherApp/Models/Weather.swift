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
    
    struct Weather: Codable {
        let id: Int
            let main, weatherDescription, icon: String

            enum CodingKeys: String, CodingKey {
                case id, main
                case weatherDescription = "description"
                case icon
            }
    }

    struct Main: Codable {
        let temp: Double
    }
}