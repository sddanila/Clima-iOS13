//
//  weatherManager.swift
//  Clima
//
//  Created by Danila Barton-Szabo on 2020-06-26.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=f191ae7449ee02603b775a808827f09f"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //      #1 Create URL
        if let url = URL(string: urlString) {
            //      #2 Create URLSession
            let session = URLSession(configuration: .default)
            //      #3 Give the Session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            //      #4 STart the task
            task.resume()
            
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
            print(decodedData.weather[0].id)
        } catch  {
            print(error)
        }
        
    }
}
