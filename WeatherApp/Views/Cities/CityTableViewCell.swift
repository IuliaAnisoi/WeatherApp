//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 07.05.2021.
//

import UIKit
import Kingfisher

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var degreesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with city: HomeElement) {
        cityNameLabel.text = city.name
        
        let url = URL(string: "https://openweathermap.org/img/wn/\(city.icon)@2x.png")
        currentWeatherIcon.kf.setImage(with: url)
        
        degreesLabel.text = String(city.rawTemperature.convertDoubleToTemperature())
    }

}
