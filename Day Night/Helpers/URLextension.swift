//
//  URLextension.swift
//  Day Night
//
//  Created by Wissam Noureddine on 7/10/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import Foundation

extension URL {
    func withQuery(_ queries : [String : String],_ fields : [String]) -> URL?{
        var componets = URLComponents(url: self, resolvingAgainstBaseURL: true)
        componets?.queryItems = queries.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        fields.forEach{
            (field) in
            componets?.queryItems?.append(URLQueryItem(name: "fields", value: field));
        }
        return componets?.url
    }
}
