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
        homeVC.title = "Alisveris"
    }

    func navigateToDetailView(with item: Product) {
        let detailVC = homeFactory.createDetailView(coordinator: self, product: item)
        rootViewController.pushViewController(detailVC, animated: true)
        let navigationTitle = UILabel()
        navigationTitle.text = "\(item.productName)"
        navigationTitle.numberOfLines = 2
        navigationTitle.textAlignment = .center
        navigationTitle.font = .systemFont(ofSize: 16, weight: .medium)
        detailVC.navigationItem.titleView = navigationTitle
    }
}