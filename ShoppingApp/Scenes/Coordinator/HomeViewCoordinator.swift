//
//  HomeViewCoordinator.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import UIKit

protocol HomeViewCoordinatorProtocol {
}

class HomeViewCoordinator: CoordinatorProtocol, HomeViewCoordinatorProtocol {

    private(set) var rootViewController: UINavigationController!

    func start() {
        let viewModel = HomeViewModel()
        let vc = HomeViewController(viewModel: viewModel)
        rootViewController = UINavigationController(rootViewController: vc)
    }
}
