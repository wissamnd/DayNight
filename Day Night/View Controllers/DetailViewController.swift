//
//  DetailViewController.swift
//  Day Night
//
//  Created by Wissam Noureddine on 24/7/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var windDirSpeedLabel: UILabel!
    @IBOutlet var visibilityLabel: UILabel!
    @IBOutlet var tempIcon: UIImageView!
    @IBOutlet var precipLabel: UILabel!
    @IBOutlet var sunsetLabel: UILabel!
    @IBOutlet var sunriseLabel: UILabel!
    @IBOutlet var precipitationAccumulation: UILabel!
    
    
    var weather : Weather?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let weather = self.weather {
            
            let temp = weather.feelsLikeTemp.maxTemp
            feelsLikeLabel.text = "Feels like: \(Int(temp))\(Constants.TEMP_UNIT)"
            setTempIcon(temp)
            
            windDirSpeedLabel.text = "Wind: \(weather.wind_direction.getMaxWindDirection()) \(Int(weather.wind_speed.maxSpeed)) \(Constants.WIND_SPEED_UNIT)"
            
            visibilityLabel.text = "Visibility: \(Int(weather.visibility.maxDistance))+ \(Constants.VISIBILITY_UNIT)"
            precipLabel.text = "Precip: \(weather.precipitation_probability.percentage) %"
            
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "h:mm a"
            sunriseLabel.text = "Sunrise: \(dateFormat.string(from: weather.sunrise!))"
            sunsetLabel.text = "Sunset: \(dateFormat.string(from: weather.sunset!))"
            precipitationAccumulation.text = "Thickness: \(weather.precipitation_accumulation!.value) \(Constants.PRECIPITATION_ACCUMULATION)"
        }
    }
    
    func setTempIcon(_ temp: Double){
        if temp < 15{
            tempIcon.image = UIImage(systemName: "thermometer.snowflake")
            tempIcon.tintColor = .systemBlue
        }else if temp >= 15 && temp <= 25{
            tempIcon.image = UIImage(systemName: "thermometer")
            tempIcon.tintColor = .green
        }else{
            tempIcon.image = UIImage(systemName: "thermometer.sun")
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
