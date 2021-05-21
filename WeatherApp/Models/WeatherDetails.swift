//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 11.05.2021.
//

import Foundation


//MARK: Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

//MARK: Current
struct Current: Codable {
    let dt: Double
    let sunrise, sunset: Int?
    let temp, feelsLike: Double
    let weather: [Weather]
    
    func getDate() -> Date{
        return NSDate(timeIntervalSince1970: dt) as Date
    }  
}

//MARK: Daily
struct Daily: Codable {
    let dt: Double
    let temp: Temp
    let windDeg: Int
    let weather: [Weather]
    
    func getDate() -> Date{
        return NSDate(timeIntervalSince1970: dt) as Date
    }
}

// MARK: Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

