//
//  Weather.swift
//  Day Night
//
//  Created by Wissam Noureddine on 7/9/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation


struct Weather : Decodable {
    var temp: Temperature
    var precipitation_probability: PrecipitationProbability
    var humidity: Humidity
    var weather_code: WeatherIcon
    var date: Date
    var feelsLikeTemp: FeelsLikeTemprature
    var wind_speed : WindSpeed
    var wind_direction : WindDirection
    var visibility : Visibility
    var sunrise : Date
    var sunset : Date
    var precipitation_accumulation : PrecipitationAccumulation
    
    
    enum CodingKeys : String, CodingKey {
        case temp
        case precipitation_probability
        case humidity
        case weather_code
        case observation_time
        case date = "value"
        case feelsLikeTemp = "feels_like"
        case wind_speed
        case wind_direction
        case visibility
        case sunset
        case sunrise
        case precipitation_accumulation
    }
    
    enum CodingKeysSunrise: String, CodingKey  {
        case sunrise = "value"
    }
    
    enum CodingKeysSunset: String, CodingKey  {
        case sunset = "value"
    }
    
    init(from decoder: Decoder)  throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // decode temperature
        self.temp = try container.decode(Temperature.self, forKey: .temp)
        
        // decode precipitation propability
        self.precipitation_probability = try container.decode(PrecipitationProbability.self, forKey: .precipitation_probability)
        
        // decode humidity
        self.humidity = try container.decode(Humidity.self, forKey: .humidity)
        
        // decode weather code
        self.weather_code = try container.decode(WeatherIcon.self, forKey: .weather_code)
        
        // decode observation time or data
        let observation_time_Container = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .observation_time)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateString = try observation_time_Container.decode(String.self, forKey: .date)
        self.date = dateFormatterGet.date(from: dateString)!
        
        
        // decode feels like temperature
        self.feelsLikeTemp = try container.decode(FeelsLikeTemprature.self, forKey: .feelsLikeTemp)
        
        // decode Wind
        self.wind_speed = try container.decode(WindSpeed.self, forKey: .wind_speed)
        self.wind_direction = try container.decode(WindDirection.self, forKey: .wind_direction)
        
        // decode visibility
        self.visibility = try container.decode(Visibility.self, forKey: .visibility)
        
        
        // decode sunrise
        let sunsrise_date_Container = try container.nestedContainer(keyedBy: CodingKeysSunrise.self, forKey: .sunrise)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateStringSunrise = try sunsrise_date_Container.decode(String.self, forKey: .sunrise)
        self.sunrise = dateFormatter.date(from: dateStringSunrise)!
        
        // decode sunset
        let sunset_date_Container = try container.nestedContainer(keyedBy: CodingKeysSunset.self, forKey: .sunset)
        let dateStringSunset = try sunset_date_Container.decode(String.self, forKey: .sunset)
        self.sunset = dateFormatter.date(from: dateStringSunset)!
        
        
        self.precipitation_accumulation = try container.decode(PrecipitationAccumulation.self, forKey: .precipitation_accumulation)
    }
}
