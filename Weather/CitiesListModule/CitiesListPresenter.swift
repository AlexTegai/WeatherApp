//
//  CitiesListPresenter.swift
//  Weather
//
//  Created by Alex Tegai on 20.10.2021.
//

import Foundation

class CitiesListPresenter: CitiesListTableViewOutputProtocol {
   
    unowned let view: CitiesListTableViewInputProtocol
    var interactor: CitiesListInteractorInputProtocol!
    var router: CitiesListRouter!
    
    required init(view: CitiesListTableViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.getCitiesListData()
    }

    func addButtonPressed(with city: String) {
        self.interactor.fetchCityWeather(with: city)
    }
    
    func didTapCell(at indexPath: IndexPath) {
        interactor.getAddedCityWeatherData(at: indexPath)
    }
}

// MARK: - Extensions -

extension CitiesListPresenter: CitiesListInteractorOutputProtocol {
    func citiesWeatherListDataReceive(with list: [CityWeather]) {
        var rows = [CityWeatherCellViewModel]()
        list.forEach { rows.append(CityWeatherCellViewModel(cityWeather: $0)) }
        let viewModel = CitiesList.ShowList.ViewModel(rows: rows)
        
        view.reloadTableDataWithRows(for: viewModel)
    }
    
    func cityWeatherDataReceive(with cityWeather: CityWeather) {
        var rows = [CityWeatherCellViewModel]()
        rows.append(CityWeatherCellViewModel(cityWeather: cityWeather))
        guard let row = rows.first else { return }
        
        view.reloadTableDataWithRow(for: row)
    }
    
    func addedCityWeatherDataReceive(with cityWeather: CityWeather) {
        router.openAddedCityWeatherViewController(with: cityWeather)
    }
    
    func fetchDataFailed() {
        view.showFailedAlert()
    }
}
