//
//  CitiesListTableViewController.swift
//  Weather
//
//  Created by Alex Tegai on 20.10.2021.
//

import SnapKit

protocol CitiesListTableViewInputProtocol: AnyObject {
    func reloadTableDataWithRows(for viewModel: CitiesWeatherViewModel)
    func reloadTableDataWithRow(for row: CityWeatherCellViewModel)
    func showFailedAlert()
}

protocol CitiesListTableViewOutputProtocol: AnyObject {
    init(view: CitiesListTableViewInputProtocol)
    func viewDidLoad()
    func addButtonPressed(with city: String)
    func didTapCell(at indexPath: IndexPath)
}

class CitiesListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Public properties -
    
    var presenter: CitiesListTableViewOutputProtocol!
    
    // MARK: - Private properties -
    
    private let configurator: CitiesListConfiguratorInputProtocol = CitiesListConfigurator()
    private var tableViewModelRows = [CityWeatherCellViewModel]()
    private let tableViewCellIdentifier = CityWeatherCellViewModel.cellIdentifier
    
    // MARK: - UIViews -

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        navBarConfigure()
        tableViewConfigure()
        presenter.viewDidLoad()
    }
}

// MARK: - CitiesListTableViewInputProtocol -

extension CitiesListTableViewController: CitiesListTableViewInputProtocol {
    func reloadTableDataWithRows(for viewModel: CitiesWeatherViewModel) {
        tableViewModelRows = viewModel.rows
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func reloadTableDataWithRow(for row: CityWeatherCellViewModel) {
        tableViewModelRows.append(row)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showFailedAlert() {
        DispatchQueue.main.async {
            let alert = AlertController(
                title: "Wrong city name",
                message: "Please, check the name of city and try again",
                preferredStyle: .alert
            )
            
            alert.okAction()
            self.present(alert, animated: true)
        }
    }
}

// MARK: - UI -

extension CitiesListTableViewController {
    
    func navBarConfigure() {
        title = "Cities List"
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrowshape.turn.up.backward"),
            style: .plain,
            target: self,
            action: #selector(returnToTheMainScreen)
        )

        navigationItem.rightBarButtonItem =
            UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector(addCity)
            )
    }
    
    func tableViewConfigure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.register(CitiesListTableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
}

// MARK: - Table view data source -

extension CitiesListTableViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModelRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = tableViewModelRows[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: tableViewCellIdentifier,
            for: indexPath
        ) as? CitiesListTableViewCell else { fatalError() }
        
        cell.viewModel = cellViewModel

        return cell
    }
}

// MARK: - Table view delegate -

extension CitiesListTableViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(tableViewModelRows[indexPath.row].cellHeight)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tableViewModelRows.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            DataManager.shared.deleteCity(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

// MARK: -  Actions -

extension CitiesListTableViewController {
    @objc private func returnToTheMainScreen() {
        dismiss(animated: true)
    }

    @objc private func addCity() {
        showAlert { city in
            self.presenter.addButtonPressed(with: city)
        }
    }
}

// MARK: - Alert Settings -

extension CitiesListTableViewController {
    private func showAlert(completion: @escaping (String) -> Void) {
        let alert = AlertController(
            title: "",
            message: "Please enter city name",
            preferredStyle: .alert
        )
        
        alert.action() { cityName in
            let city = cityName.trimmingCharacters(
                in: .whitespaces
            ).replacingOccurrences(of: " ", with: "+")
            completion(city)
        }

        present(alert, animated: true)
    }
}
