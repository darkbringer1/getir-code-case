//
//  DetailViewController.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import UIKit

class DetailViewController: UIViewController {
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
        viewModel.subscribeDetailDataState { product in
            self.detailComponent.set(data: self.viewModel.formatData())
        }
        viewModel.subscribeDetailDataChangeListener { state in
            switch state {
            case .dataChanged:
                self.detailComponent.set(data: self.viewModel.formatData())
                self.detailComponent.reloadCollectionView()
            case .dataStable:
                break
            }
        }
        viewModel.getProductData()
    }
}
