//
//  CitiesListConfigurator.swift
//  Weather
//
//  Created by Alex Tegai on 20.10.2021.
//

protocol CitiesListConfiguratorInputProtocol {
    func configure(with viewController: CitiesListTableViewController)
}

class CitiesListConfigurator: CitiesListConfiguratorInputProtocol {
    func configure(with viewController: CitiesListTableViewController) {
        let presenter = CitiesListPresenter(view: viewController)
        let interactor = CitiesListInteractor(presenter: presenter)
        let router = CitiesListRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
