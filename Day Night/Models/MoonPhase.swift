//
//  MoonPhase.swift
//  Day Night
//
//  Created by Wissam Noureddine on 6/8/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation

class MoonPhase {
    var phase : String
    var names = [
        "new" : "New",
        "waxing_crescent" : "Waxing crescent" ,
        "first_quarter" : "First quarter" ,
        "waxing_gibbous" : "Waxing gibbous" ,
        "full" : "Full",
        "waning_gibbous" : "Waning gibbous",
        "last_quarter" : "Last quarter",
        "waning_crescent" : "Waxing crescent"
    ]
    init(phase : String) {
        self.phase = phase
    }
    
    func getName() -> String? {
        if let name = names[phase]{
            return name + " moon"
        }
        return nil
    }
}
