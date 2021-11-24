//
//  HomePageInteractor.swift
//  Weather
//
//  Created by Alex Tegai on 12.10.2021.
//

import Foundation
import UIKit

protocol HomePageInteractorInputProtocol: AnyObject {
    init(presenter: HomePageInteractorOutputProtocol)
    func fetchWeather(of city: String)
}

protocol HomePageInteractorOutputProtocol: AnyObject {
    func receiveCityWeather(with cityWeather: WeatherData) 
}

class HomePageInteractor: HomePageInteractorInputProtocol {
  
    unowned let presenter: HomePageInteractorOutputProtocol
    
    required init(presenter: HomePageInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchWeather(of city: String) {
        let cityWeather = city
            .trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: " ", with: "+")
        
        NetworkManager.shared.fetchData(city: cityWeather) { result in
            switch result {
            case .success(let cityWeather):
                guard
                    let iconString = cityWeather.weather.first?.icon,
                    let iconURL = URL(string: "\(NetworkManager.shared.iconUrl)\(iconString)@2x.png")
                else { return }
                
                if let cachedImage = DataManager.shared.getCachedImage(from: iconURL) {
                    let weather = WeatherData(
                        cityName: cityWeather.name,
                        icon: cachedImage,
                        condition: cityWeather.weather.first?.description,
                        temp: cityWeather.main.temp,
                        speed: cityWeather.wind.speed,
                        humidity: cityWeather.main.humidity,
                        minTemp: cityWeather.main.tempMin,
                        maxTemp: cityWeather.main.tempMax,
                        feelsLike: cityWeather.main.feelsLike,
                        pressure: cityWeather.main.pressure
                    )
                    self.presenter.receiveCityWeather(with: weather)
                    return
                }
                
                NetworkManager.shared.fetchIcon(from: iconURL) { data, response in
                    let weather = WeatherData(
                        cityName: cityWeather.name,
                        icon: data,
                        condition: cityWeather.weather.first?.description,
                        temp: cityWeather.main.temp,
                        speed: cityWeather.wind.speed,
                        humidity: cityWeather.main.humidity,
                        minTemp: cityWeather.main.tempMin,
                        maxTemp: cityWeather.main.tempMax,
                        feelsLike: cityWeather.main.feelsLike,
                        pressure: cityWeather.main.pressure
                    )
                    self.presenter.receiveCityWeather(with: weather)
                
                    DataManager.shared.saveDataToCache(with: data, and: response)
                }

            case .failure(let error):
                print(error)
            }
        }
    }
}
