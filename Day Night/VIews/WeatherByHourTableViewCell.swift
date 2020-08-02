//
//  WeatherByHourTableViewCell.swift
//  Day Night
//
//  Created by Wissam Noureddine on 29/7/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import UIKit

class WeatherByHourTableViewCell: UITableViewCell {
    @IBOutlet var weatherIconImageView: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var precipitationPropabilityLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    var weather : WeatherByHour?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(_ w : WeatherByHour){
        self.weather = w
        tempLabel.text = ""
        timeLabel.text = ""
        guard let weather = weather else {return}
        
        tempLabel.text = String(weather.temp.rounded())+Constants.TEMP_UNIT
        
        weatherIconImageView.image = weather.weather_code.getWeatherIcon()!
        
        let df = DateFormatter()
        df.dateFormat = "EEE d, h a"
        timeLabel.text = df.string(from: weather.observation_time)
        
        precipitationPropabilityLabel.text = "\(Int(weather.precipitation_probability))%"
        
        
        
    }

}
