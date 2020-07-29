//
//  Humidity.swift
//  Day Night
//
//  Created by Wissam Noureddine on 7/10/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation

struct Humidity : Decodable {
    var minHumidity : Double
    var maxHumidity : Double
    
    enum CodingKeysMin : String , CodingKey{
        case minHumidity = "value"
        case min
    }
    enum CodingKeysMax : String , CodingKey {
        case maxHumidity = "value"
        case max
    }
    
    init(from decoder : Decoder) throws{
        var container = try decoder.unkeyedContainer()
        let firstDictionary = try container.nestedContainer(keyedBy: CodingKeysMin.self)
        let minContainer = try firstDictionary.nestedContainer(keyedBy: CodingKeysMin.self, forKey: .min)
        self.minHumidity = try minContainer.decode(Double.self, forKey: .minHumidity)
        
        let secondDictionary = try container.nestedContainer(keyedBy: CodingKeysMax.self)
        let maxContainer = try secondDictionary.nestedContainer(keyedBy: CodingKeysMax.self, forKey: .max)
        self.maxHumidity = try maxContainer.decode(Double.self, forKey: .maxHumidity)
    }
    
    
}
