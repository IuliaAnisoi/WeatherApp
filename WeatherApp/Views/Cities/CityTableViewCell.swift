//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 07.05.2021.
//

import UIKit

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
     //   currentWeatherIcon.image = city.icon.image
        degreesLabel.text = city.temperature
    }

}
