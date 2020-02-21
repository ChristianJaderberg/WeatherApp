//
//  ClothingTip.swift
//  WeatherApp
//
//  Created by Christian Jäderberg on 2020-02-17.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import Foundation

struct ClothingTip {
    
    func getTip(weather: ConsolidatedWeather) -> String {
        
        let temp = weather.theTemp
        let abbr = weather.weatherStateAbbr
        var firstTip, secondTip: String
        
        // set firstTip
        switch temp {
        case -(Double.infinity)..<(-20.0):
            firstTip = "polar clothes"
                
        case -20.0..<0.0:
            firstTip = "winter clothes"
                
        case 0.0..<10.0:
            firstTip = "warm clothes"
                
        case 10.0..<20.0:
            firstTip = "a thin jacket"
                
        case 20.0..<30.0:
            firstTip = "thin clothes"
                
        case 30.0...(Double.infinity):
            firstTip = "swim clothes"
                
        default:
            fatalError()
        }
        
        // set secondTip
        switch abbr {
        case "sn":
            secondTip = " and snowshoes"
                
        case "sl", "h", "hr", "lr", "s":
            secondTip = " and an umbrella"
                
        case "hc":
            secondTip = " and a smile"
                
        case "c", "lc":
            secondTip = " and sunglasses"
                
        case "t":
            secondTip = " and an umbrella, but don't go outside, because it's dangerous"
                
        default:
            fatalError()
        }
        
        return "\"You need " + firstTip + secondTip + ". Touch me for some action.\""
    }
    
}
