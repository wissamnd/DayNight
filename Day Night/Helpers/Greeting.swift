//
//  Greeting.swift
//  Day Night
//
//  Created by Wissam Noureddine on 7/15/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation

class Greeting {
    
    static func getString() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 6..<12 : return "Good Morning"
        case 12..<18 : return "Good Afternoon"
        case 18..<21 : return "Good Evening"
        default: return "Good Night"
        }
        
        
    }
    
    private static func getTimeUntilDate(futureDate : Date) -> Double {
        let elapsedTime = futureDate.timeIntervalSinceNow
        return elapsedTime
    }
    
    static func getSunriseSunsetText(weather : Weather) -> (timeUntil : String, systemIcon: String)?{
        
        let timeUntilSunrise = getTimeUntilDate(futureDate: weather.sunrise!)
        let timeUntilSunset = getTimeUntilDate(futureDate: weather.sunset!)
        if timeUntilSunrise > 0 {
             // convert from seconds to hours, rounding down to the nearest hour
            let hours = floor(timeUntilSunrise / 60 / 60)
            let minutes = floor((timeUntilSunrise - (hours * 60 * 60)) / 60)
            return ("\(Int(abs(hours))) hr \(Int(abs(minutes))) min", "sunrise")
        }else if timeUntilSunset > 0{
            let hours = floor(timeUntilSunset / 60 / 60)
            let minutes = floor((timeUntilSunset - (hours * 60 * 60)) / 60)
            return ("\(Int(abs(hours))) hr \(Int(abs(minutes))) min", "sunset")
        }
        return nil
        
    }
}
