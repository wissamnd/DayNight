//
//  Visibility.swift
//  Day Night
//
//  Created by Wissam Noureddine on 23/7/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation
struct Visibility: Decodable{
    var minDistance : Double
    var maxDistance : Double
    
    enum CodingKeysMin: String, CodingKey {
        case min
        case minDistance = "value"
    }
    
    enum CodingKeysMax: String ,CodingKey{
        case max
        case maxDistance = "value"
    }
    
    init(from decoder : Decoder) throws {
        var container = try decoder.unkeyedContainer()
        // Fetching information from first dictionary which contains the min temperature
        let firstDictionary = try container.nestedContainer(keyedBy: CodingKeysMin.self)
        let minContainer = try firstDictionary.nestedContainer(keyedBy: CodingKeysMin.self, forKey: .min)
        self.minDistance = try minContainer.decode(Double.self, forKey: .minDistance)
        // Fetching information from second dictionary which contains the max temperature
        let secondDictionary = try container.nestedContainer(keyedBy: CodingKeysMax.self)
        let maxContainer = try secondDictionary.nestedContainer(keyedBy: CodingKeysMax.self, forKey: .max)
        self.maxDistance = try maxContainer.decode(Double.self, forKey: .maxDistance)
    }
    
    
}
