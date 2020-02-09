//
//  SearchHandler.swift
//  WeatherApp
//
//  Created by Christian Jäderberg on 2020-02-07.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import Foundation

struct API {
    
    let baseURL: String = "https://www.metaweather.com/api/location/"
    let searchURL: String = "search/?query="
    // let APIKey: String = "&APPID=8ac26e01e81f51b695c3daa8ad31d8d5"
    
    func searchLocation(searchString: String, completion: @escaping( Result<[Location], Error>) -> Void) {
        
        var locationArray = [Location]()
        
        // url
        let urlString = baseURL + searchURL + searchString
        
        guard let url: URL = URL(string: urlString) else { return }
        
        // Request
        print("Creating request..")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let unwrappedError = error {
                print("Nåt gick fel. Error: \(unwrappedError)")
                completion(.failure(unwrappedError))
                return
            }
            if let unwrappedData = data {
                print("We got data! \(String(data: unwrappedData, encoding: String.Encoding.utf8) ?? "No data")")
                do {
                    let decoder = JSONDecoder()
                    locationArray = try decoder.decode([Location].self, from: unwrappedData)
                    // print("Location name: \(locationArray[0].title)")
                    completion(.success(locationArray))
                } catch {
                    print("Couldnt parse JSON..")
                }                
            }
        }
        // Starta task
        task.resume()
        print("Task started")
    }
    
}
