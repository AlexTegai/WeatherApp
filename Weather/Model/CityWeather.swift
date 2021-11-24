//
//  Weather.swift
//  Weather
//
//  Created by Alex Tegai on 12.10.2021.
//

import Foundation

struct CityWeather: Codable {
    let name: String?
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Weather: Codable {
    let description: String?
    let icon: String?
}

struct Main: Codable {
    let temp: Float?
    let feelsLike: Float?
    let humidity: Int?
    let tempMin: Float?
    let tempMax: Float?
    let pressure: Int?
}

struct Wind: Codable {
    let speed : Float?
}
