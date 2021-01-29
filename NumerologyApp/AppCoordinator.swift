//
//  AppCoordinator.swift
//  NumerologyApp
//
//  Created by Tetiana on 29.01.2021.
//

import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    private var navigationController: UINavigationController?
    private let window: UIWindow

    private var serviceHolder: ServiceHolder!
    private var startCoordinator: MainCoordinatorType?

    init(window: UIWindow) {
        self.window = window
        
        startServices()
    }
    
    private func startServices() {
        serviceHolder = ServiceHolder()
        let userService = UserService()
        serviceHolder.add(UserServiceType.self, for: userService)
        navigationController = UINavigationController()
    }
    
    func start() {
        navigationController = UINavigationController()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        startCoordinator = MainCoordinator(navigationController: navigationController, serviceHolder: serviceHolder)
        startCoordinator?.start()
    }
}
