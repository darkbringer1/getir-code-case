//
//  HomeViewCoordinator.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import UIKit

protocol HomeViewCoordinatorProtocol {
    func navigateToDetailView(with item: Product, addToBasket: @escaping AddToBasketStateBlock)
    func navigateToBasketView()
}

final class HomeViewCoordinator: CoordinatorProtocol, HomeViewCoordinatorProtocol {

    private(set) var rootViewController: UINavigationController!
    private let homeFactory: HomeFactory

    init(homeFactory: HomeFactory) {
        self.homeFactory = homeFactory
    }

    func start() {
        let homeVC = homeFactory.createHomeView(coordinator: self)
        rootViewController = UINavigationController(rootViewController: homeVC)
        homeVC.title = "Alisveris"
        rootViewController.navigationBar.tintColor = .systemMint
    }

    func navigateToDetailView(with item: Product, addToBasket: @escaping AddToBasketStateBlock) {
        let detailVC = homeFactory.createDetailView(coordinator: self, product: item, addToBasket: addToBasket)
        rootViewController.pushViewController(detailVC, animated: true)
        let navigationTitle = UILabel()
        navigationTitle.text = "\(item.productName)"
        navigationTitle.numberOfLines = 2
        navigationTitle.textAlignment = .center
        navigationTitle.font = .systemFont(ofSize: 16, weight: .medium)
        detailVC.navigationItem.titleView = navigationTitle
    }

    func navigateToBasketView() {
        let basketVC = homeFactory.goToBasketView(coordinator: self)
        rootViewController.pushViewController(basketVC, animated: true)
        let navigationTitle = UILabel()
        navigationTitle.text = "Sepetim"
        navigationTitle.textAlignment = .center
        navigationTitle.font = .systemFont(ofSize: 16, weight: .medium)
        basketVC.navigationItem.titleView = navigationTitle
    }
}
