//
//  HomeCoordinator.swift
//  LetsGoTravel
//
//  Created by Natali Malich
//

import UIKit

class HomeCoordinator: CoordinatorProtocol {
    
    // MARK: - Properties
    weak var parentCoordinator: AppCoordinator?
    let navigationController: UINavigationController
    var childCoordinators = [CoordinatorProtocol]()
    
    // MARK: - Initializer
    required init() {
        self.navigationController = UINavigationController()
    }
    
    // MARK: - Funcs
    func openHomeViewController() {
        let homeViewController: HomeViewController = HomeViewController()
        homeViewController.coordinator = self
        homeViewController.title = "Список авиабилетов"
        self.navigationController.navigationItem.largeTitleDisplayMode = .always
        self.navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        self.navigationController.viewControllers = [homeViewController]
    }
}

extension HomeCoordinator: HomeViewControllerCoordinatorDelegate {
    func navigateToDetailVC(flight: Flight?) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController)
        detailCoordinator.delegate = self
        childCoordinators.append(detailCoordinator)
        detailCoordinator.openDetailViewController(flight: flight)
    }
}

extension HomeCoordinator: BackToHomeViewControllerDelegate {
    func navigateToPreviousPage(newOrderCoordinator: DetailCoordinator) {
        navigationController.popToRootViewController(animated: false)
        childCoordinators.removeLast()
    }
}
