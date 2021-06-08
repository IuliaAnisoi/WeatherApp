//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 11.05.2021.
//

import Foundation
import UIKit

struct WeatherDetails: Codable {
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

//MARK: Current
struct Current: Codable {
    let dt: Double
    let temp: Double
    let weather: [Weather]
    
}

//MARK: Daily
struct Daily: Codable {
    let dt: Double
    let temp: Temp
    let weather: [Weather]
    
    func getDate() -> String {
        let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
        let formattedDate = formatter.string(from: NSDate(timeIntervalSince1970: dt) as Date)
        return formattedDate
    }
}

//MARK: Hourly
struct Hourly: Codable {
    let dt: Double
    let temp: Double
    let weather: [Weather]
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let formattedDate = formatter.string(from: NSDate(timeIntervalSince1970: dt) as Date)
        return formattedDate
    }
}

// MARK: Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}


extension Double {
    func convertDoubleToTemperature() -> String {
        let roundedValue = Darwin.round(self * 10) / 10
        let mf = MeasurementFormatter()
        let temp = Measurement(value: roundedValue, unit: UnitTemperature.celsius)
        mf.locale = Locale(identifier: "en_GB")
        return mf.string(from: temp)
    }
}
