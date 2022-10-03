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
        addMainComponent()
        viewModelListeners()
        configureNavigationBar()
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

    func viewModelListeners() {
        viewModel.subscribeNetworkState()
        viewModel.subscribeHomeViewState { [weak self] viewState in
            switch viewState {
            case .loading:
                break
            case .done:
                self?.homeCVComponent.reloadCollectionView()
            case .error:
                break
            }
        }
    }

    func configureNavigationBar() {
        let rightButtonView = UIButton(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        rightButtonView.setImage(UIImage(systemName: "cart"), for: .normal)
        rightButtonView.addTarget(self, action: #selector(tap), for: .touchUpInside)
        rightButtonView.tintColor = .systemMint
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButtonView)

    }

    @objc func tap() {
        print("sepet")
        viewModel.navigateToBasket()
    }
}
