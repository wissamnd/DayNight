//
//  PrecipitationProbability.swift
//  Day Night
//
//  Created by Wissam Noureddine on 7/10/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation

struct PrecipitationProbability : Decodable{
    var percentage : Double
    
    enum CodingKeys : String , CodingKey {
        case percentage = "value"
    }
    
    init(from decoder : Decoder)  throws{
        let container = try decoder.container(keyedBy: CodingKeys.self);
        self.percentage = try container.decode(Double.self, forKey: .percentage)
    }
}
 
