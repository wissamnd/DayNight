//
//  Temprature.swift
//  Day Night
//
//  Created by Wissam Noureddine on 7/9/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation


struct Temperature : Decodable {
    var minTemp: Double
    var maxTemp: Double
    
    enum CodingKeysMin : String, CodingKey {
        case min
        case minTemp = "value"
        
    }
    enum CodingKeysMax : String, CodingKey {
        case max
        case maxTemp = "value"
        
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        // Fetching information from first dictionary which contains the min temperature
        let firstDictionary = try container.nestedContainer(keyedBy: CodingKeysMin.self)
        let minContainer = try firstDictionary.nestedContainer(keyedBy: CodingKeysMin.self, forKey: .min)
        self.minTemp = try minContainer.decode(Double.self, forKey: .minTemp)
        // Fetching information from second dictionary which contains the max temperature
        let secondDictionary = try container.nestedContainer(keyedBy: CodingKeysMax.self)
        let maxContainer = try secondDictionary.nestedContainer(keyedBy: CodingKeysMax.self, forKey: .max)
        self.maxTemp = try maxContainer.decode(Double.self, forKey: .maxTemp)
    }
}

