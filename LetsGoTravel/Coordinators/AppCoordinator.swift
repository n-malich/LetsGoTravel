//
//  AppCoordinator.swift
//  LetsGoTravel
//
//  Created by Natali Malich
//

import UIKit

public protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] {get set}
}

class AppCoordinator: CoordinatorProtocol {
    
    // MARK: - Properties
    var childCoordinators = [CoordinatorProtocol]()
    let window: UIWindow?

    // MARK: - Initializer
    init(window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
    }

    // MARK: - Funcs
    func start() {
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.parentCoordinator = self
        homeCoordinator.openHomeViewController()
        
        let homeViewController = homeCoordinator.navigationController
        
        self.window?.rootViewController = homeViewController
    }
}

