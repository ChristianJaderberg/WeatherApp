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
    
    // takes a given search-string, sends it to API, decodes the result data and puts the result in an array
    func searchLocation(searchString: String, completion: @escaping( Result<[Location], Error>) -> Void) {
        
        var locationArray = [Location]()
        
        // url
        let urlString = baseURL + searchURL + searchString
        
        guard let url: URL = URL(string: urlString) else { return }
        
        // Request
        print("Requesting")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let unwrappedError = error {
                print("Caught error: \(unwrappedError)")
                completion(.failure(unwrappedError))
                return
            }
            if let unwrappedData = data {
                print("Data was found: \(String(data: unwrappedData, encoding: String.Encoding.utf8) ?? "No data was found")")
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .secondsSince1970
                    locationArray = try decoder.decode([Location].self, from: unwrappedData)
                    completion(.success(locationArray))
                } catch {
                    print("Unable to parse JSON")
                }                
            }
        }
        // Starta task
        task.resume()
        print("Task started")
    }
    
    func getWeather(woeid: Int, completion: @escaping( Result<Weather, Error>) -> Void) {
        
        // url
        let urlString = baseURL + String(woeid)
        
        guard let url: URL = URL(string: urlString) else { return }
        
        // Request
        print("Requesting")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let unwrappedError = error {
                print("Caught error: \(unwrappedError)")
                completion(.failure(unwrappedError))
                return
            }
            if let unwrappedData = data {
                print("Data was found: \(String(data: unwrappedData, encoding: String.Encoding.utf8) ?? "No data was found")")
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let weather = try decoder.decode(Weather.self, from: unwrappedData)
                    completion(.success(weather))
                } catch {
                    print("Unable to parse JSON")
                }
            }
        }
        // Starta task
        task.resume()
        print("Task started")
    }
    
}
