//
//  WeatherData.swift
//  Clima
//
//  Created by Иван Семенов on 11.03.2024.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let name: String
}
// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}
// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}
// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}


