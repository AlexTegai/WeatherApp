//
//  AddedCityWeatherInteractor.swift
//  Weather
//
//  Created by Alex Tegai on 26.10.2021.
//
import Foundation

protocol AddedCityWeatherInteractorInputProtocol: AnyObject {
    init(
        presenter: AddedCityWeatherInteractorOutputProtocol,
        cityWeather: CityWeather
    )
    func provideWeather()
}

protocol AddedCityWeatherInteractorOutputProtocol: AnyObject {
    func receiveData(with cityWeather: AddedCityWeatherData)
}

class AddedCityWeatherInteractor: AddedCityWeatherInteractorInputProtocol {
   
    unowned let presenter: AddedCityWeatherInteractorOutputProtocol
    private let cityWeather: CityWeather
    
    required init(
        presenter: AddedCityWeatherInteractorOutputProtocol,
        cityWeather: CityWeather
    ) {
        self.presenter = presenter
        self.cityWeather = cityWeather
    }
    
    func provideWeather() {
        guard
            let iconString = cityWeather.weather.first?.icon,
            let iconURL = URL(string: "\(NetworkManager.shared.iconUrl)\(iconString)@2x.png")
        else { return }
        
        if let cachedImage = DataManager.shared.getCachedImage(from: iconURL) {
            let weatherData = AddedCityWeatherData(
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
            self.presenter.receiveData(with: weatherData)
            return
        }
        
        NetworkManager.shared.fetchIcon(from: iconURL) { data, response in
            let weatherData = AddedCityWeatherData(
                cityName: self.cityWeather.name,
                icon: data,
                condition: self.cityWeather.weather.first?.description,
                temp: self.cityWeather.main.temp,
                speed: self.cityWeather.wind.speed,
                humidity: self.cityWeather.main.humidity,
                minTemp: self.cityWeather.main.tempMin,
                maxTemp: self.cityWeather.main.tempMax,
                feelsLike: self.cityWeather.main.feelsLike,
                pressure: self.cityWeather.main.pressure
            )
            self.presenter.receiveData(with: weatherData)
        }
    }
}

