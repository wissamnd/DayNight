//
//  Model.swift
//  Day Night
//
//  Created by Wissam Noureddine on 7/10/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation

protocol ModelDelegate {
    func WeatherFetched(_ weatherList: [Weather])
}
protocol ModelWeatherByHourDelegate {
    func WeatherFetched(_ weatherList : [WeatherByHour])
}

class Model {
    
    var delegate: ModelDelegate?
    var weatherByHourDelegate : ModelWeatherByHourDelegate?
    
    func fetch15DaysWeather( latitude : Double, longitude : Double){
        let baseurl = URL(string: Constants.CLIMACELL_API_BASE_URL)!
        let query : [String : String] = [
            "apikey" : Constants.CLIMACELL_API_KEY,
            "lat" : String(latitude),
            "lon" : String(longitude),
        ]
        let fields : [String] = [
            "temp",
            "humidity",
            "precipitation_probability",
            "weather_code",
            "feels_like",
            "wind_speed",
            "wind_direction",
            "precipitation",
            "precipitation_accumulation",
            "sunrise",
            "sunset",
            "visibility"
        ]
        let url = baseurl.withQuery(query, fields)!
        let task = URLSession.shared.dataTask(with: url) {
            (data , response , error ) in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            if let data = data , let WeatherList = try? jsonDecoder.decode([Weather].self,from: data){
                DispatchQueue.main.async {
                    self.delegate?.WeatherFetched(WeatherList)
                }
            }else {
                print("Either no data was returned, or data was not properly decoded")
            }
        }
        task.resume()
    }
    func fetch96HoursWeather( latitude : Double, longitude : Double){
        let baseurl = URL(string: Constants.CLIMACELL_API_BASE_URL_HOURLY)!
        let query : [String : String] = [
            "apikey" : Constants.CLIMACELL_API_KEY,
            "lat" : String(latitude),
            "lon" : String(longitude),
        ]
        let fields : [String] = [
            "temp",
            "humidity",
            "precipitation_probability",
            "weather_code",
            "feels_like",
            "wind_speed",
            "wind_direction",
            "precipitation",
            "visibility",
            "moon_phase"
        ]
        let url = baseurl.withQuery(query, fields)!
        let task = URLSession.shared.dataTask(with: url) {
            (data , response , error ) in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            if let data = data , let WeatherList = try? jsonDecoder.decode([WeatherByHour].self,from: data){
                DispatchQueue.main.async {
                    self.weatherByHourDelegate?.WeatherFetched(WeatherList)
                }
            }else {
                print("Either no data was returned, or data was not properly decoded")
            }
        }
        task.resume()
    }
}
