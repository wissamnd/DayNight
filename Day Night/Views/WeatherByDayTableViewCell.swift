//
//  WeatherByDayTableViewCell.swift
//  Day Night
//
//  Created by Wissam Noureddine on 7/11/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import UIKit

class WeatherByDayTableViewCell: UITableViewCell {

    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var precipitationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var weather : Weather?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCell(_ w : Weather){
        self.weather = w
        tempLabel.text = ""
        dateLabel.text = ""
        minTempLabel.text = ""
        guard let weather = weather else {return}
        
        tempLabel.text = String(weather.temp.maxTemp.rounded())+Constants.TEMP_UNIT
        
        weatherIcon.image = weather.weather_code.getWeatherIconDay()!
        
        minTempLabel.text = "/ \(weather.temp.minTemp.rounded())\(Constants.TEMP_UNIT)"
        
        let df = DateFormatter()
        df.dateFormat = "EEE M/d"
        dateLabel.text = df.string(from: weather.date)
        
        precipitationLabel.text = "\(Int(weather.precipitation_probability.percentage))%"
        
        
        
    }
    


}
