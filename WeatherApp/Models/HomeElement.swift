//
//  City.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 07.05.2021.
//

import Foundation
import UIKit
import CoreLocation

struct HomeElement: Codable {
    var latitude: Double
    var longitude: Double
    var name: String
    var icon: String
    var rawTemperature: Double
}
