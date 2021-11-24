//
//  HomePageConfigurator.swift
//  Weather
//
//  Created by Alex Tegai on 12.10.2021.
//

protocol HomePageConfiguratorInputProtocol {
    func configure(with viewController: HomePageViewController)
}

class HomePageConfigurator: HomePageConfiguratorInputProtocol {
    func configure(with viewController: HomePageViewController) {
        
        let presenter = HomePagePresenter(view: viewController)
        let interactor = HomePageInteractor(presenter: presenter)
        let router = HomePageRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
