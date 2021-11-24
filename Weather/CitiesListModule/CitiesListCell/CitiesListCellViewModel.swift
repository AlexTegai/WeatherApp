//
//  CitiesListCellViewModel.swift
//  Weather
//
//  Created by Alex Tegai on 21.10.2021.
//

import Foundation

typealias CityWeatherCellViewModel = CitiesList.ShowList.ViewModel.CityWeatherCellViewModel
typealias CitiesWeatherViewModel = CitiesList.ShowList.ViewModel

protocol CellIdentifiable {
    static var cellIdentifier: String { get }
    var cellHeight: Double { get }
}

enum CitiesList {
 
    // MARK: - Use cases -
    
    enum ShowList {
        struct Response {
            let citiesWeather: [CityWeather]
        }
        
        struct ViewModel {
            struct CityWeatherCellViewModel: CellIdentifiable {
                let cityName: String?
                let icon: String?
                let condition: String?
                
                static var cellIdentifier: String {
                    "cell"
                }
                
                var cellHeight: Double {
                    100
                }
                
                init(cityWeather: CityWeather) {
                    cityName = cityWeather.name
                    icon = cityWeather.weather.first?.icon
                    condition = cityWeather.weather.first?.description
                }
            }
            let rows: [CityWeatherCellViewModel]
        }
    }
}
