//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by Christian Jäderberg on 2020-02-06.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    var location = Location()
    
    @IBOutlet weak var locationNavigation: UINavigationItem!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let api = API()
    var currentWeather = Weather()
    var currentWeatherDay = ConsolidatedWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationNavigation.title = self.location.title
        locationLabel.text = self.location.title
        
        getWeather(woeid: location.woeid)
    }
    
    func getWeather(woeid: Int) -> Void {
        print("getWeather-Method called")
        // TODO progress indicator start
        api.getWeather(woeid: woeid) { (result) in
            switch result {
            case .success(let weather):
                self.currentWeather = weather
                self.currentWeatherDay = weather.consolidatedWeather[0]
                print(self.currentWeather)
                
                DispatchQueue.main.async {
                    // Update UI
                    self.tempLabel.text = String(round(10 * self.currentWeatherDay.theTemp) / 10)
                    self.maxTempLabel.text = String(round(10 * self.currentWeatherDay.maxTemp) / 10)
                    self.minTempLabel.text = String(round(10 * self.currentWeatherDay.minTemp) / 10)
                    self.humidityLabel.text = String(self.currentWeatherDay.humidity) + " %"
                    self.descriptionLabel.text = self.currentWeatherDay.weatherStateName
                    self.dateLabel.text = self.currentWeatherDay.applicableDate
                    
                    // TODO progress indicator stop
                }
            case .failure(let error): print("Error \(error)")
            }
        }
    }
}
