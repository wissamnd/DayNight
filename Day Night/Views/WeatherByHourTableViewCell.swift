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
        
        
        
        
        
        let date = weather.observation_time
        let df = DateFormatter()
        df.dateFormat = "EEE, h a"
        
        let day = Calendar.current.component(.day, from: date)
        let todaysDay = Calendar.current.component(.day, from: Date())
        
        if(day == todaysDay){
            df.dateFormat = "h a"
            timeLabel.text = "Today, " + df.string(from: date)
        }else if (day == todaysDay + 1){
            df.dateFormat = "h a"
            timeLabel.text = "Tommorow, " + df.string(from: date)
        }else {
            df.dateFormat = "EEE, h a"
            timeLabel.text = df.string(from: date)
            
        }
        
        // assign the weather icon based on the time of the day
        let hour = Calendar.current.component(.hour, from: weather.observation_time)
        if hour > 6 && hour < 19 {
            weatherIconImageView.image = weather.weather_code.getWeatherIconDay()!
        }else{
            weatherIconImageView.image = weather.weather_code.getWeatherIconNight()!
        }
        
        
        
        
        precipitationPropabilityLabel.text = "\(Int(weather.precipitation_probability))%"
        
        
        
    }
    
}
