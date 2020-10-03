//
//  Constants.swift
//  Day Night
//
//  Created by Wissam Noureddine on 7/8/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation

struct Constants {
    
    // Add your api key here
    static var CLIMACELL_API_KEY = ""
    
    static var CLIMACELL_API_BASE_URL = "https://api.climacell.co/v3/weather/forecast/daily"
    static var CLIMACELL_API_BASE_URL_HOURLY = "https://api.climacell.co/v3/weather/forecast/hourly"
    static var WEATHER_BY_DAY_CELL_REUSABLE_ID = "WeatherByDayCell"
    static var WEATHER_BY_HOUR_CELL_REUSABLE_ID = "WeatherByHourCell"
    static var TEMP_UNIT = "°"
    static var WIND_SPEED_UNIT = "m/s"
    static var WIND_DIRCTION_UNIT = "degrees"
    static var VISIBILITY_UNIT = "km"
    static var PRECIPITATION_ACCUMULATION = "mm"
}
