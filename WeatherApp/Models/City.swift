//
//  City.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 07.05.2021.
//

import Foundation
import UIKit
import CoreLocation

struct City {
    var coordinates: CLLocationCoordinate2D
    var name: String
    var icon: String
    var rawTemperature: Double
        var temperature: String {
        let roundedValue = round(rawTemperature * 10) / 10.0
        let mf = MeasurementFormatter()
        let temp = Measurement(value: roundedValue, unit: UnitTemperature.celsius)
        mf.locale = Locale(identifier: "en_GB")
        return mf.string(from: temp)
    }
    
}
