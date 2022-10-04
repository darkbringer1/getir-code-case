//
//  HomeViewController.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import UIKit

final class HomeViewController: UIViewController, ErrorHandlingProtocol {
    
    var viewModel: HomeViewModelProtocol!
    private var homeCVComponent: HomeCVComponent!

    convenience init(viewModel: HomeViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        viewModel.homeViewStateListener { [weak self] viewState in
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
        addRightBarButton(imageSystemName: "cart") { [weak self] in
            self?.viewModel.navigateToBasket {
                self?.showAlert(with: Alert(title: "Sepetinizde hic urun bulunmamaktadir",
                                      message: "",
                                      actions: [AlertAction(title: "Tamam",
                                                            style: .default,
                                                            action: nil)],
                                      style: .alert))
            }
        }
    }
}
