//
//  HomeViewCoordinator.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import UIKit

protocol HomeViewCoordinatorProtocol {
    func navigateToDetailView(with item: Product)
}

class HomeViewCoordinator: CoordinatorProtocol, HomeViewCoordinatorProtocol {

    private(set) var rootViewController: UINavigationController!
    private let homeFactory: HomeFactory

    init(homeFactory: HomeFactory) {
        self.homeFactory = homeFactory
    }

    func start() {
        let homeVC = homeFactory.createHomeView(coordinator: self)
        rootViewController = UINavigationController(rootViewController: homeVC)
    }

    func navigateToDetailView(with item: Product) {
        let detailVC = homeFactory.createDetailView(coordinator: self, product: item)
        rootViewController.pushViewController(detailVC, animated: true)
    }
}
