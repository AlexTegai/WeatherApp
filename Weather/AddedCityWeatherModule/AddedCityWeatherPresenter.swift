//
//  AddedCityWeatherPresenter.swift
//  Weather
//
//  Created by Alex Tegai on 26.10.2021.
//

import Foundation

struct AddedCityWeatherData {
    let cityName: String?
    let icon: Data?
    let condition: String?
    let temp: Float?
    let speed: Float?
    let humidity: Int?
    let minTemp: Float?
    let maxTemp: Float?
    let feelsLike: Float?
    let pressure: Int?
}

class AddedCityWeatherPresenter: AddedCityWeatherViewOutputProtocol {
    unowned let view: AddedCityWeatherViewInputProtocol
    var interactor: AddedCityWeatherInteractorInputProtocol!
    
    required init(view: AddedCityWeatherViewInputProtocol) {
        self.view = view
    }
    
    func showAddedCityWeather() {
        interactor.provideWeather()
    }
}

// MARK: - AddedCityWeatherInteractorOutputProtocol -

extension AddedCityWeatherPresenter: AddedCityWeatherInteractorOutputProtocol {
    func receiveData(with cityWeather: AddedCityWeatherData) {
        
        guard
            let city = cityWeather.cityName,
            let icon = cityWeather.icon,
            let condition = cityWeather.condition,
            let temp = cityWeather.temp,
            let speed = cityWeather.speed,
            let humidity = cityWeather.humidity,
            let minTemp = cityWeather.minTemp,
            let maxTemp = cityWeather.maxTemp,
            let feelsLike = cityWeather.feelsLike,
            let pressure = cityWeather.pressure
        else { return }

        view.displayConditionColor(with: condition)
        view.displayCityName(with: city)
        view.displayImage(with: icon)
        view.displayCondition(with: condition)
        view.displayTemperature(with: String(Int(temp)))
        view.displayWindSpeed(with: String(Int(speed)))
        view.displayHumidity(with: String(humidity))
        view.displayMinTemp(with: String(Int(minTemp)))
        view.displayMaxTemp(with: String(Int(maxTemp)))
        view.displayFeelsLikeTemp(with: String(Int(feelsLike)))
        view.displayPressure(with: String(pressure))
    }
}
