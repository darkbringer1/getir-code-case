//
//  HomeFactory.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import UIKit

final class HomeFactory {
    private let coreDataManager = CoreDataManager.shared

    func createHomeView(coordinator: HomeViewCoordinatorProtocol) -> UIViewController {
        let shoppingListDataManager = ShoppingListCoreDataManager()
        shoppingListDataManager.coreDataManager = coreDataManager
        let formatter = HomeDataFormatter(shoppingListCoreDataManager: shoppingListDataManager)
        let networkChecker = NetworkCheckerManager.shared
        let viewModel = HomeViewModel(coordinator: coordinator, formatter: formatter, networkChecker: networkChecker)
        let vc = HomeViewController(viewModel: viewModel)
        return vc
    }

    func createDetailView(coordinator: HomeViewCoordinatorProtocol, product: Product, addToBasket: @escaping AddToBasketStateBlock) -> UIViewController {
        let viewModel = DetailViewModel(productData: product, addToBasket: addToBasket)
        viewModel.coordinator = coordinator
        let vc = DetailViewController(viewModel: viewModel)
        return vc
    }

    func goToBasketView(coordinator: HomeViewCoordinatorProtocol) -> UIViewController {
        let viewModel = BasketViewModel()
        let shoppingListDataManager = ShoppingListCoreDataManager()
        viewModel.coordinator = coordinator
        viewModel.shoppingListDataManager = shoppingListDataManager
        let vc = BasketViewController(viewModel: viewModel)
        return vc
    }
}
