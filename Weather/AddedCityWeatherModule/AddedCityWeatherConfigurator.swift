//
//  AddedCityWeatherConfigurator.swift
//  Weather
//
//  Created by Alex Tegai on 26.10.2021.
//

protocol AddedCityWeatherConfiguratorInputProtocol {
    func configure(
        with view: AddedCityWeatherViewController,
        and cityWeather: CityWeather
    )
}

class AddedCityWeatherConfigurator: AddedCityWeatherConfiguratorInputProtocol {
    func configure(
        with view: AddedCityWeatherViewController,
        and cityWeather: CityWeather
    ) {
        let presenter = AddedCityWeatherPresenter(view: view)
        let interactor = AddedCityWeatherInteractor(presenter: presenter, cityWeather: cityWeather)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
