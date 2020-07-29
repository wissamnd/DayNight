//
//  Wind.swift
//  Day Night
//
//  Created by Wissam Noureddine on 23/7/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation


struct WindSpeed: Decodable{
    var minSpeed : Double
    var maxSpeed : Double
    
    enum CodingKeysMin: String, CodingKey {
        case min
        case minSpeed = "value"
    }
    
    enum CodingKeysMax: String ,CodingKey{
        case max
        case maxSpeed = "value"
    }
    
    init(from decoder : Decoder) throws {
        var container = try decoder.unkeyedContainer()
        // Fetching information from first dictionary which contains the min temperature
        let firstDictionary = try container.nestedContainer(keyedBy: CodingKeysMin.self)
        let minContainer = try firstDictionary.nestedContainer(keyedBy: CodingKeysMin.self, forKey: .min)
        self.minSpeed = try minContainer.decode(Double.self, forKey: .minSpeed)
        // Fetching information from second dictionary which contains the max temperature
        let secondDictionary = try container.nestedContainer(keyedBy: CodingKeysMax.self)
        let maxContainer = try secondDictionary.nestedContainer(keyedBy: CodingKeysMax.self, forKey: .max)
        self.maxSpeed = try maxContainer.decode(Double.self, forKey: .maxSpeed)
    }
    
    
}
