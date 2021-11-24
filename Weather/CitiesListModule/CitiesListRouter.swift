//
//  CitiesListRouter.swift
//  Weather
//
//  Created by Alex Tegai on 20.10.2021.
//

protocol CitiesListRouterInputProtocol {
    init(viewController: CitiesListTableViewController)
    func openAddedCityWeatherViewController(with cityWeather: CityWeather)
}

class CitiesListRouter: CitiesListRouterInputProtocol {
    unowned let viewController: CitiesListTableViewController
    
    required init(viewController: CitiesListTableViewController) {
        self.viewController = viewController
    }
    
    func openAddedCityWeatherViewController(with cityWeather: CityWeather) {
        let addedCityWeatherVC = AddedCityWeatherViewController()
        let addedCityWeatherConfigurator: AddedCityWeatherConfiguratorInputProtocol = AddedCityWeatherConfigurator()
        addedCityWeatherConfigurator.configure(with: addedCityWeatherVC, and: cityWeather)
        
        viewController.present(addedCityWeatherVC, animated: true)
    }
}
