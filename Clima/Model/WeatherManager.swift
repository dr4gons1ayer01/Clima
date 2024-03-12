//
//  WeatherManager.swift
//  Clima
//
//  Created by Иван Семенов on 08.03.2024.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let url = "https://api.openweathermap.org/data/2.5/weather?&appid=b9c81050cef9855eeaca27cf97ae5d26&units=metric&lang=ru"
    
    func fetchWeather(city: String) {
        let urlStr = "\(url)&q=\(city)"
        performRequest(with: urlStr)
    }
    func fetchWeather(latitide: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlStr = "\(url)&lat=\(latitide)&lon=\(longitude)"
        performRequest(with: urlStr)
    }
    
    var delegate: WeatherManagerDelegate?
    
    func performRequest(with urlStr: String) {
        //1. Create a URL
        if let url = URL(string: urlStr) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id,
                                       cityName: name,
                                       temp: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
