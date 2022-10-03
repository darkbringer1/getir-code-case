//
//  HomeFactory.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import UIKit

final class HomeFactory {
    func createHomeView(coordinator: HomeViewCoordinatorProtocol) -> UIViewController {
        let formatter = HomeDataFormatter()
        let networkChecker = NetworkCheckerManager.shared
        let viewModel = HomeViewModel(formatter: formatter, networkChecker: networkChecker)
        viewModel.coordinator = coordinator
        let vc = HomeViewController(viewModel: viewModel)
        return vc
    }

    func createDetailView(coordinator: HomeViewCoordinatorProtocol, product: Product) -> UIViewController {
        let viewModel = DetailViewModel(productData: product)
        viewModel.coordinator = coordinator
        let vc = DetailViewController(viewModel: viewModel)
        return vc
    }
}
