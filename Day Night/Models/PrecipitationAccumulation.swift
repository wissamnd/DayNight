//
//  PrecipitationAccumulation.swift
//  Day Night
//
//  Created by Wissam Noureddine on 26/7/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation

struct PrecipitationAccumulation : Decodable{
    var value : Double
    
    enum CodingKeys : String , CodingKey {
        case value
    }
    
    init(from decoder : Decoder)  throws{
        let container = try decoder.container(keyedBy: CodingKeys.self);
        self.value = try container.decode(Double.self, forKey: .value)
    }
}
 
