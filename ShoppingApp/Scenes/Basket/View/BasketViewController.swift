//
//  BasketViewController.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 4.10.2022.
//

import UIKit

class BasketViewController: UIViewController {
    var viewModel: BasketViewModelProtocol!
    private var mainComponent: BasketCollectionViewComponent!

    convenience init(viewModel: BasketViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMainComponent()
    }

    private func addMainComponent() {
        mainComponent = BasketCollectionViewComponent()
        mainComponent.translatesAutoresizingMaskIntoConstraints = false
        mainComponent.dataProvider = viewModel
        mainComponent.set(data: viewModel.getCollectionViewData())
        
        view.addSubview(mainComponent)

        NSLayoutConstraint.activate([
            mainComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainComponent.topAnchor.constraint(equalTo: view.topAnchor),
            mainComponent.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        mainComponent.reloadCollectionView()
    }
}
