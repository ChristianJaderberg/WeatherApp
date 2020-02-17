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
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var clothingTipTextview: UITextView!
    
    let api = API()
    var currentWeather = Weather()
    var currentWeatherDay = ConsolidatedWeather()
    var clothingTip = ClothingTip()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationNavigation.title = self.location.title
        locationLabel.text = self.location.title
        
        getWeather(woeid: location.woeid)
        
        animateWeather()
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
                    
                    self.setWeatherImage(weatherAbbr: self.currentWeatherDay.weatherStateAbbr)
                    self.tempLabel.text = String(round(10 * self.currentWeatherDay.theTemp) / 10)
                    self.maxTempLabel.text = String(round(10 * self.currentWeatherDay.maxTemp) / 10)
                    self.minTempLabel.text = String(round(10 * self.currentWeatherDay.minTemp) / 10)
                    self.humidityLabel.text = String(self.currentWeatherDay.humidity) + " %"
                    self.descriptionLabel.text = self.currentWeatherDay.weatherStateName
                    self.dateLabel.text = self.currentWeatherDay.applicableDate
                    self.clothingTipTextview.text = self.clothingTip.getTip(weather: self.currentWeatherDay)
                    
                    // TODO progress indicator stop
                }
            case .failure(let error): print("Error \(error)")
            }
        }
    }
    
    func setWeatherImage(weatherAbbr: String) {
        let url = "https://www.metaweather.com/static/img/weather/png/\(weatherAbbr).png"
        guard let imageURL = URL(string: url) else { return }
        self.weatherImageView.downloadImage(from: imageURL)
    }
    
    func animateWeather() {
        UIView.animate(withDuration: 1, animations: {
            self.weatherImageView.frame.origin.y -= 20
        }){_ in
            UIView.animateKeyframes(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat], animations: {
                self.weatherImageView.frame.origin.y += 20
            })
        }
    }
}

extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else { return }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}
