//
//  HomeViewController.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol!
    private var homeCVComponent: HomeCVComponent!

    convenience init(viewModel: HomeViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        viewModelListener()
        addMainComponent()
    }

    func addMainComponent() {
        homeCVComponent = HomeCVComponent()
        homeCVComponent.translatesAutoresizingMaskIntoConstraints = false
        homeCVComponent.dataProvider = viewModel

        view.addSubview(homeCVComponent)
        NSLayoutConstraint.activate([
            homeCVComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeCVComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeCVComponent.topAnchor.constraint(equalTo: view.topAnchor),
            homeCVComponent.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func viewModelListener() {
        viewModel.getData()
        viewModel.subscribeHomeViewState { [weak self] state in
            switch state {
            case .loading:
                break
            case .done:
                self?.homeCVComponent.reloadCollectionView()
            case .error:
                break
            }
        }
    }
}
