//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 10.05.2021.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(with hourlyDetails: Hourly) {
        hourLabel.text = hourlyDetails.getDate()
        
        let url = URL(string: "https://openweathermap.org/img/wn/\(hourlyDetails.weather.first?.icon ?? "")@2x.png")
        iconImage.kf.setImage(with: url)
        
        temperatureLabel.text = String(hourlyDetails.temp.convertDoubleToTemperature())
    }
}
