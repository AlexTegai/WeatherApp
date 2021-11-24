//
//  HomePageRouter.swift
//  Weather
//
//  Created by Alex Tegai on 12.10.2021.
//

import UIKit

protocol HomePageRouterInputProtocol {
    init(viewController: HomePageViewController)
    func openCitiesListTableViewController()
}

class HomePageRouter: HomePageRouterInputProtocol {
    unowned let viewController: HomePageViewController
    
    required init(viewController: HomePageViewController) {
        self.viewController = viewController
    }
    
    func openCitiesListTableViewController() {
        let citiesListTableViewController = UINavigationController(
            rootViewController: CitiesListTableViewController()
        )
        citiesListTableViewController.modalPresentationStyle = .fullScreen
                                                                    
        viewController.present(citiesListTableViewController, animated: true)
    }
}
