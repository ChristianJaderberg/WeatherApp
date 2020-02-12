//
//  Weather.swift
//  WeatherApp
//
//  Created by Christian Jäderberg on 2020-02-09.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let consolidatedWeather: [ConsolidatedWeather]
    let parent: Parent
    let title, locationType: String
    let woeid: Int
    
    init() {
        self.consolidatedWeather = []
        self.parent = Parent()
        self.title = ""
        self.locationType = ""
        self.woeid = 0
    }
    
}

// MARK: - ConsolidatedWeather
struct ConsolidatedWeather: Codable {
    let weatherStateName, weatherStateAbbr: String
    let applicableDate: String
    let minTemp, maxTemp, theTemp: Double
    let humidity: Int
    
    init() {
        self.weatherStateName = ""
        self.weatherStateAbbr = ""
        self.applicableDate = ""
        self.minTemp = 0.0
        self.maxTemp = 0.0
        self.theTemp = 0.0
        self.humidity = 0
    }
}

// MARK: - Parent
struct Parent: Codable {
    let title, locationType: String
    let woeid: Int
    
    init() {
        self.title = ""
        self.locationType = ""
        self.woeid = 0
    }
}
