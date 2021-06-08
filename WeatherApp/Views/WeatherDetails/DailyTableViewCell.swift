//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 10.05.2021.
//

import UIKit
import Kingfisher

class DailyTableViewCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with day: Daily) {
        dayLabel.text = day.getDate()
    
        let url = URL(string: "https://openweathermap.org/img/wn/\(day.weather.first?.icon ?? "")@2x.png")
        iconImage.kf.setImage(with: url)
        
        minLabel.text = day.temp.min.convertDoubleToTemperature()
        maxLabel.text = day.temp.max.convertDoubleToTemperature()
    }


}
