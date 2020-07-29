//
//  FeelsLikeTemprature.swift
//  Day Night
//
//  Created by Wissam Noureddine on 23/7/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation

struct FeelsLikeTemprature : Decodable {
    var minTemp : Double
    var maxTemp : Double
    
    enum CodingKeysMin : String , CodingKey {
        case min
        case minTemp = "value"
    }
    enum CodingKeysMax : String , CodingKey {
        case max
        case maxTemp = "value"
    }
    
    init(from decoder : Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        // min
        let minTempDictionary = try container.nestedContainer(keyedBy: CodingKeysMin.self)
        let minTempContainer = try minTempDictionary.nestedContainer(keyedBy: CodingKeysMin.self, forKey: .min)
        
        self.minTemp = try minTempContainer.decode(Double.self, forKey: .minTemp)
        
        // max
        let maxTempDictionary = try container.nestedContainer(keyedBy: CodingKeysMax.self)
        let maxTempContainer = try maxTempDictionary.nestedContainer(keyedBy: CodingKeysMax.self, forKey: .max)
        self.maxTemp = try maxTempContainer.decode(Double.self, forKey: .maxTemp)
    }
}
