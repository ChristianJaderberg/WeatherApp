//
//  Location.swift
//  WeatherApp
//
//  Created by Christian Jäderberg on 2020-02-07.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import Foundation

struct Location: Codable {
    
    let title: String
    let woeid: Int
    
    init() {
        self.title = "Location"
        self.woeid = 0
    }
    
}
