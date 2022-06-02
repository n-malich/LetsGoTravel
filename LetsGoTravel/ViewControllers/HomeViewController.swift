//
//  HomeViewController.swift
//  LetsGoTravel
//
//  Created by Natali Malich
//

import UIKit

protocol HomeViewControllerCoordinatorDelegate: AnyObject {
    func navigateToDetailVC(flight: Flight?)
}

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var coordinator: HomeViewControllerCoordinatorDelegate?
    private var isInitiallyLoaded = false
    private var flights: [Flight]?
    private let flightCellID = String(describing: FlightTableViewCell.self)
    
    // MARK: - UI Elements
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FlightTableViewCell.self, forCellReuseIdentifier: flightCellID)
        tableView.activateAnchors()
        return tableView
    }()
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        activityIndicatorView.activateAnchors()
        return activityIndicatorView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super .viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Data
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Флаг, который гарантирует загрузку данных 1 раз
        if !isInitiallyLoaded {
            isInitiallyLoaded.toggle()
            showSpinner()
            NetworkService.shared.fetchFlights { [weak self] flights in
                self?.flights = flights
                self?.tableView.reloadData()
                self?.hideSpinner()
            }
        }
        self.tableView.reloadData()
    }
    
    private func showSpinner() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
    }
    
    private func hideSpinner() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
}

    // MARK: - Setup Views
extension HomeViewController {
    private func setupViews() {
        view.addSubviews(tableView, activityIndicatorView)
    }
}

    // MARK: - Setup Constraints
extension HomeViewController {
    private func setupConstraints() {
        [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        .forEach { $0.isActive = true }
    }
}

// MARK: - TableViewDataSource, TableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FlightTableViewCell = tableView.dequeueReusableCell(withIdentifier: flightCellID, for: indexPath) as! FlightTableViewCell
        if let flight = flights?[indexPath.row] {
            cell.showFlight(flight: flight)
        }
        
        if FavoriteManager.shared.checkFlightStatus(token: cell.searchTokenFlights) {
            cell.favoriteView.paintBookmarkImage()
        } else {
            cell.favoriteView.unPaintBookmarkImage()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator?.navigateToDetailVC(flight: flights?[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
