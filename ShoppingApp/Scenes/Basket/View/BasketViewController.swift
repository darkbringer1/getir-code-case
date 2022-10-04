//
//  BasketViewController.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 4.10.2022.
//

import UIKit

final class BasketViewController: UIViewController {
    var viewModel: BasketViewModelProtocol!
    private var mainComponent: BasketCollectionViewComponent!

    convenience init(viewModel: BasketViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMainComponent()
        subscribeToViewModelListeners()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainComponent.set(data: viewModel.getCollectionViewData())
    }

    private func addMainComponent() {
        mainComponent = BasketCollectionViewComponent()
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
        viewModel.subscribeToViewStateListener { [weak self] state in
            switch state {
            case .loading:
                self?.mainComponent.set(data: self?.viewModel.getCollectionViewData())
            case .done:
                self?.mainComponent.reloadCollectionView()
            case .error:
                break
            }
        }
    }
}
