//
//  NowTableViewCell.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 10.05.2021.
//

import UIKit
import Kingfisher

class NowTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func update(with currentDetails: Current) {
        
        let url = URL(string: "https://openweathermap.org/img/wn/\(currentDetails.weather.first?.icon ?? "")@2x.png")
        iconImage.kf.setImage(with: url)
        
        currentWeatherLabel.text = String(currentDetails.temp.convertDoubleToTemperature())
        descriptionLabel.text = currentDetails.weather.first?.weatherDescription
    }
}
