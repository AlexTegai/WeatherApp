//
//  CitiesListTableViewCell.swift
//  Weather
//
//  Created by Alex Tegai on 21.10.2021.
//

import UIKit

protocol CellModelRepresentable {
    var viewModel: CellIdentifiable? { get set }
}

class CitiesListTableViewCell: UITableViewCell, CellModelRepresentable {
    
    // MARK: - Public properties -

    var viewModel: CellIdentifiable? {
        didSet {
            updateTable()
        }
    }
    
    // MARK: - Private properties -

    private func updateTable() {
        guard let viewModel = viewModel as? CityWeatherCellViewModel else { return }
        var content = defaultContentConfiguration()
        
        guard
            let iconString = viewModel.icon,
            let iconURL = URL(string: "\(NetworkManager.shared.iconUrl)\(iconString)@2x.png"),
            let cityName = viewModel.cityName,
            let condition = viewModel.condition
        else { return }
        
        if let cachedImage = DataManager.shared.getCachedImage(from: iconURL) {
            content.image = UIImage(data: cachedImage)
            content.text = cityName
            content.secondaryText = condition
            content.textProperties.color = .white
            content.secondaryTextProperties.color = .white
            
            self.contentView.superview?.backgroundColor = .black
            self.contentConfiguration = content
            return
        }
        
        NetworkManager.shared.fetchIcon(from: iconURL) { data, response in
            content.image = UIImage(data: data)
            content.text = cityName
            content.secondaryText = condition
            content.textProperties.color = .white
            content.secondaryTextProperties.color = .white
            
            self.contentView.superview?.backgroundColor = .black
            self.contentConfiguration = content
        }
    }
}





