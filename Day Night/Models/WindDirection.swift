//
//  WindDirection.swift
//  Day Night
//
//  Created by Wissam Noureddine on 23/7/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation
struct WindDirection: Decodable{
    var minAngle : Double
    var maxAngle : Double
    
    enum CodingKeysMin: String, CodingKey {
        case min
        case minAngle = "value"
    }
    
    enum CodingKeysMax: String ,CodingKey{
        case max
        case maxAngle = "value"
    }
    
    init(from decoder : Decoder) throws {
        var container = try decoder.unkeyedContainer()
        // Fetching information from first dictionary which contains the min temperature
        let firstDictionary = try container.nestedContainer(keyedBy: CodingKeysMin.self)
        let minContainer = try firstDictionary.nestedContainer(keyedBy: CodingKeysMin.self, forKey: .min)
        self.minAngle = try minContainer.decode(Double.self, forKey: .minAngle)
        // Fetching information from second dictionary which contains the max temperature
        let secondDictionary = try container.nestedContainer(keyedBy: CodingKeysMax.self)
        let maxContainer = try secondDictionary.nestedContainer(keyedBy: CodingKeysMax.self, forKey: .max)
        self.maxAngle = try maxContainer.decode(Double.self, forKey: .maxAngle)
    }
    
    func getMaxWindDirection() -> String {
        if maxAngle == 0{
            return "E"
        }else if maxAngle > 0  && maxAngle < 90{
            return "NE"
        }else if maxAngle == 90{
            return "N"
        }else if maxAngle > 90 && maxAngle < 180{
            return "NW"
        }else if maxAngle == 180{
            return "W"
        }else if maxAngle > 180 && maxAngle < 270{
            return "SW"
        }else if maxAngle == 270 {
            return "S"
        }else{
            return "SE"
        }
    }
    
    
}
