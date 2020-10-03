//
//  DetailWeatherByHourViewController.swift
//  Day Night
//
//  Created by Wissam Noureddine on 7/8/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import UIKit

class DetailWeatherByHourViewController: UIViewController {
    
    var weather : WeatherByHour?

    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var windDirectionAndSpeedLabel: UILabel!
    @IBOutlet var visibilityLabel: UILabel!
    @IBOutlet var precipitationPropLabel: UILabel!
    @IBOutlet var moonPhaseLabel: UILabel!
    @IBOutlet var precipotationThicknessLabel: UILabel!
    @IBOutlet var moonPhaseIcon: UIImageView!
    @IBOutlet var tempIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let weather = weather {
            let temp = weather.temp
            feelsLikeLabel.text = "Feels like: \(Int(temp))\(Constants.TEMP_UNIT)"
            windDirectionAndSpeedLabel.text = "Wind: \(weather.wind_direction.getMaxWindDirection()) \(Int(weather.wind_speed)) \(Constants.WIND_SPEED_UNIT)"
            
            visibilityLabel.text = "Visibility: \(Int(weather.visibility))+ \(Constants.VISIBILITY_UNIT)"
            precipitationPropLabel.text = "Precip: \(weather.precipitation_probability) %"
            moonPhaseLabel.text = weather.moon_phase.getName()
            moonPhaseIcon.image = UIImage(named: weather.moon_phase.phase)
            precipotationThicknessLabel.text = "Thickness: \(weather.precipitation) \(Constants.PRECIPITATION_ACCUMULATION)"
            
        }
    }
    
    func setTempIcon(_ temp: Double){
        if temp < 15{
            tempIcon.image = UIImage(named: "thermometer.snowflake")
            tempIcon.tintColor = .systemBlue
        }else if temp >= 15 && temp <= 25{
            tempIcon.image = UIImage(named: "thermometer")
            tempIcon.tintColor = .green
        }else{
            tempIcon.image = UIImage(named: "thermometer.sun")
            tempIcon.tintColor = .systemYellow
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
