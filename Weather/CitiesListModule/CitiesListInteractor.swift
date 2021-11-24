//
//  CitiesListInteractor.swift
//  Weather
//
//  Created by Alex Tegai on 20.10.2021.
//

import Foundation

protocol CitiesListInteractorInputProtocol: AnyObject {
    init(presenter: CitiesListInteractorOutputProtocol)
    func getCitiesListData()
    func fetchCityWeather(with city: String)
    func getAddedCityWeatherData(at indexPath: IndexPath)
}

protocol CitiesListInteractorOutputProtocol: AnyObject {
    func citiesWeatherListDataReceive(with list: [CityWeather])
    func cityWeatherDataReceive(with cityWeather: CityWeather)
    func addedCityWeatherDataReceive(with cityWeather: CityWeather)
    func fetchDataFailed()
}

class CitiesListInteractor: CitiesListInteractorInputProtocol {
    unowned let presenter: CitiesListInteractorOutputProtocol
    
    required init(presenter: CitiesListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func getCitiesListData() {
        let citiesList = DataManager.shared.fetchCities()
        presenter.citiesWeatherListDataReceive(with: citiesList)
    }
    
    func fetchCityWeather(with city: String) {
        NetworkManager.shared.fetchData(city: city) { result in
            switch result {
            case .success(let cityWeather):
                self.presenter.cityWeatherDataReceive(with: cityWeather)
                DataManager.shared.save(city: cityWeather)
            case .failure(let error):
                self.presenter.fetchDataFailed()
                print(error)
            }
        }
    }
    
    func getAddedCityWeatherData(at indexPath: IndexPath) {
        let cityWeather = DataManager.shared.getCity(at: indexPath.row)
        presenter.addedCityWeatherDataReceive(with: cityWeather)
    }
}
