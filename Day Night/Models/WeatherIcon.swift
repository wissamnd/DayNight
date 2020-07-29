//
//  WeatherIcon.swift
//  Day Night
//
//  Created by Wissam Noureddine on 7/10/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation
import UIKit

struct WeatherIcon : Decodable{
    var value : String
    
    enum CodingKeys : String , CodingKey {
        case value
    }
    
    init(from decoder : Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(String.self, forKey: .value)
    }
    
    func getWeatherIcon() -> UIImage? {
        switch value {
        case "partly_cloudy":
            return UIImage(named: "partly_cloudy_day")
        case "mostly_clear":
            return UIImage(named: "mostly_clear_day")
        case "clear":
            return UIImage(named: "clear_day")
        default:
            return UIImage(named: value)
        }
    }
    
    func getWeatherIconNight() -> UIImage? {
        switch value {
        case "partly_cloudy":
            return UIImage(named: "partly_cloudy_night")
        case "mostly_clear":
            return UIImage(named: "partly_cloudy_night")
        case "clear":
            return UIImage(named: "clear_night")
        default:
            return UIImage(named: value)
        }
    }
    
}
