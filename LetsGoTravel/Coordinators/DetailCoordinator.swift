//
//  DetailCoordinator.swift
//  LetsGoTravel
//
//  Created by Natali Malich
//

import UIKit

protocol BackToHomeViewControllerDelegate: AnyObject {
    func navigateToPreviousPage(newOrderCoordinator: DetailCoordinator)
}

class DetailCoordinator: CoordinatorProtocol {
    
    // MARK: - Properties
    weak var delegate: BackToHomeViewControllerDelegate?
    var childCoordinators = [CoordinatorProtocol]()
    unowned let navigationController: UINavigationController
    
    // MARK: - Initializer
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Funcs
    func openDetailViewController(flight: Flight?) {
        let detailViewController: DetailViewController = DetailViewController()
        detailViewController.flight = flight
        self.navigationController.navigationBar.topItem?.backButtonTitle = "Все билеты"
        self.navigationController.navigationBar.tintColor = UIColor.appColor(.blueDark)
        self.navigationController.viewControllers.append(detailViewController)
    }
}
