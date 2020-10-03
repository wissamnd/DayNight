//
//  Hour.swift
//  Day Night
//
//  Created by Wissam Noureddine on 2/8/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation

struct WeatherByHour : Decodable {
    var temp : Double
    var feels_like : Double
    var precipitation : Double
    var precipitation_probability : Double
    var humidity : Double
    var wind_speed : Double
    var wind_direction : WindDirection
    var visibility : Double
    var observation_time : Date
    var weather_code : WeatherIcon
    var moon_phase : MoonPhase
    
    
    
    
    
    enum CodingKeys : String , CodingKey{
        case temp
        case feels_like
        case precipitation
        case value
        case precipitation_probability
        case weather_code
        case observation_time
        case humidity
        case wind_speed
        case visibility
        case wind_direction
        case moon_phase
    }
    
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // decode temperature
        let tempratureContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .temp)
        self.temp = try tempratureContainer.decode(Double.self, forKey: .value)
        
        // decode feelsLike
        let feelsLikeContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .feels_like)
        self.feels_like = try feelsLikeContainer.decode(Double.self, forKey: .value)
        
        // decode precipitation
        let precipitationContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .precipitation)
        self.precipitation = try precipitationContainer.decode(Double.self, forKey: .value)
        
        // decode precipitation propability
        let precipitaionPropabilityContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .precipitation_probability)
        self.precipitation_probability = try precipitaionPropabilityContainer.decode(Double.self, forKey: .value)
        
        // decode weather code
        self.weather_code = try container.decode(WeatherIcon.self, forKey: .weather_code)
        
        // decode observation Time
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let observationTimeContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .observation_time)
        let dateString = try observationTimeContainer.decode(String.self, forKey: .value)
        self.observation_time = dateFormatter.date(from: dateString)!
        
        // decode humidity
        let humidityContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .humidity)
        self.humidity = try humidityContainer.decode(Double.self, forKey: .value)
        
        // decode wind speed
        let windSpeedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .wind_speed)
        self.wind_speed = try windSpeedContainer.decode(Double.self, forKey: .value)
        
        // decode visibility
        let visibilityContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .visibility)
        self.visibility = try visibilityContainer.decode(Double.self, forKey: .value)
        
        // decode wind direction
        let windDirectionContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .wind_direction)
        let windAngle = try windDirectionContainer.decode(Double.self, forKey: .value)
        self.wind_direction = WindDirection(maxAngle: windAngle)
        
        // decode moon phase
        let moonPhaseContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .moon_phase)
        let moonPhase : String = try moonPhaseContainer.decode(String.self, forKey: .value)
        self.moon_phase = MoonPhase(phase: moonPhase)
    }
}
