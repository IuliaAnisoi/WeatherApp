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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with city: City) {
        cityNameLabel.text = city.name
        currentWeatherIcon.backgroundColor = UIColor(red: 0.31, green: 0.76, blue: 0.97, alpha: 1.00)
        let url = URL(string: "https://openweathermap.org/img/wn/\(city.icon)@2x.png")
        currentWeatherIcon.kf.setImage(with: url)
        
        degreesLabel.text = String(city.temperature)
    }

}
