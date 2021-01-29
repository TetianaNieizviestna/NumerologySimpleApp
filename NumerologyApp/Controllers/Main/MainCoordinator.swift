//
//  MainCoordinator.swift
//  NumerologyApp
//
//  Created by Tetiana on 29.01.2021.
//

import UIKit

protocol MainCoordinatorType: Coordinator {
    func showAlert(title: String, message: String)
}

final class MainCoordinator: MainCoordinatorType {
    
    private weak var controller: MainViewController? = Storyboard.main.instantiateViewController()
    private let navigationController: UINavigationController?
    private var serviceHolder: ServiceHolder!
    
    init(navigationController: UINavigationController?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController

        self.serviceHolder = serviceHolder
        controller?.viewModel = MainViewModel(self, serviceHolder: serviceHolder)
    }
    
    func start() {
        if let controller = controller {
            controller.modalTransitionStyle = .crossDissolve
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func showAlert(title: String, message: String) {
        if let controller = controller {
            controller.showAlert(title: title, message: message)
        }
    }
}
