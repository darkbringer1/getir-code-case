//
//  BasketViewController.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 4.10.2022.
//

import UIKit

final class BasketViewController: UIViewController, ErrorHandlingProtocol {
    private var viewModel: BasketViewModelProtocol!
    private var mainComponent: BasketViewComponent!

    convenience init(viewModel: BasketViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addMainComponent()
        subscribeToViewModelListeners()
        configureNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainComponent.set(data: viewModel.getCollectionViewData())
    }

    private func addMainComponent() {
        mainComponent = BasketViewComponent()
        mainComponent.translatesAutoresizingMaskIntoConstraints = false
        mainComponent.dataProvider = viewModel

        view.addSubview(mainComponent)
        NSLayoutConstraint.activate([
            mainComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainComponent.topAnchor.constraint(equalTo: view.topAnchor),
            mainComponent.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func subscribeToViewModelListeners() {
        viewModel.viewStateListener { [weak self] state in
            switch state {
            case .loading:
                self?.mainComponent.set(data: self?.viewModel.getCollectionViewData())
            case .done:
                self?.mainComponent.reloadCollectionView()
            }
        }
        viewModel.orderConfirmedListener { [weak self] in
            guard let self = self else { return }
            self.showAlert(with: self.viewModel.showOrderConfirmedAlert {
                self.popViewController()
            })
        }
    }

    private func configureNavigationBar() {
        addDefaultBackBarButton { [weak self] in
            self?.popViewController()
        }
    }
}
