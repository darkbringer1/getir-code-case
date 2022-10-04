//
//  DetailViewController.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import UIKit

final class DetailViewController: UIViewController, ErrorHandlingProtocol {
    var viewModel: DetailViewModelProtocol!
    private var detailComponent: ProductDetailView!

    convenience init(viewModel: DetailViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addMainComponent()
        subscribeViewModelListeners()
        configureNavigationBar()
    }

    private func addMainComponent() {
        detailComponent = ProductDetailView()
        detailComponent.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailComponent)

        NSLayoutConstraint.activate([
            detailComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailComponent.topAnchor.constraint(equalTo: view.topAnchor),
            detailComponent.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func subscribeViewModelListeners() {
        viewModel.addToBasketListener { [weak self] state in
            guard let self = self else { return }
            switch state {
            case true:
                self.showAlert(with: self.viewModel.showAddedToBasketAlert())
            case false:
                break
            }
        }
        viewModel.detailDataState { [weak self] product in
            self?.detailComponent.set(data: self?.viewModel.formatData())
        }
        viewModel.detailDataChangeListener { [weak self] state in
            switch state {
            case .dataChanged:
                self?.detailComponent.set(data: self?.viewModel.formatData())
                self?.detailComponent.reloadCollectionView()
            case .dataStable:
                break
            }
        }
        viewModel.getProductData()
    }

    private func configureNavigationBar() {
        addDefaultBackBarButton { [weak self] in
            self?.popViewController()
        }
    }
}
