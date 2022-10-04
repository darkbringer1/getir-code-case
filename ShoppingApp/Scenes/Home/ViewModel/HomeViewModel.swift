//
//  HomeViewModel.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation
import NetworkLayer

typealias HomeViewStateBlock = (HomeViewState) -> Void

protocol HomeViewModelProtocol: HomeDataProviderProtocol {
    func getData()
    func homeViewStateListener(with completion: @escaping HomeViewStateBlock)
    func subscribeNetworkState()
    func navigateToBasket(with completion: @escaping () -> Void) 
}

final class HomeViewModel: HomeViewModelProtocol {
    private var coordinator: HomeViewCoordinatorProtocol?
    private var dataFormatter: HomeDataFormatterProtocol

    // View states
    var homeViewState: HomeViewStateBlock?

    // Managers
    var networkChecker: NetworkCheckerManager

    init(coordinator: HomeViewCoordinatorProtocol,
         formatter: HomeDataFormatterProtocol,
         networkChecker: NetworkCheckerManager) {
        self.coordinator = coordinator
        self.dataFormatter = formatter
        self.networkChecker = networkChecker
    }

    func getData() {
        homeViewState?(.loading)
        do {
            guard let urlRequest = try? ProductService(request: Request()).returnURLRequest() else { return }
            apiCall(with: urlRequest, completion: dataListener)
        }
    }

    func subscribeNetworkState() {
        networkChecker.startNetworkListener { [weak self] networkState in
            switch networkState {
            case .online:
                // MARK: - online data call
                self?.getData()
            case .offline:
                // MARK: - get items from core data if any
                self?.dataResponseHandler(from: self?.dataFormatter.getItemsFromDisk())
            }
        }
    }

    func homeViewStateListener(with completion: @escaping HomeViewStateBlock) {
        homeViewState = completion
    }

    func navigateToBasket(with completion: @escaping () -> Void) {
        if dataFormatter.getBasketItemCount() ?? 0 > 0 {
            coordinator?.navigateToBasketView()
        } else {
            completion()
        }
    }

    private func apiCall(with urlRequest: URLRequest, completion: @escaping (Result<ProductResponse, Error>) -> Void) {
        APIManager.shared.executeRequest(urlRequest: urlRequest, completion: completion)
    }

    private lazy var dataListener: (Result<ProductResponse, Error>) -> Void = { [weak self] result in
        switch result {
        case .failure(let error):
            self?.homeViewState?(.error)
            self?.dataResponseHandler(from: self?.dataFormatter.getItemsFromDisk())
        case .success(let response):
            self?.dataFormatter.saveItems(from: response)
            self?.dataResponseHandler(from: self?.dataFormatter.getItemsFromDisk())
        }
    }

    private lazy var retryAction: () -> Void = {
        self.getData()
    }

    private func dataResponseHandler(from response: ProductResponse?) {
        guard let response = response else {
            homeViewState?(.error)
            return
        }
        dataFormatter.setData(with: response)
        homeViewState?(.done)
    }
}

// MARK: - CV Data Provider
extension HomeViewModel: HomeDataProviderProtocol {
    func askNumberOfItem(in section: Int) -> Int {
        dataFormatter.getNumberOfItems(in: section) ?? 0
    } 

    func askData(at index: Int) -> GenericDataProtocol? {
        dataFormatter.askData(at: index)
    }

    func selectedItem(at index: Int) {
        guard let product = dataFormatter.getItem(at: index) else { return }
        coordinator?.navigateToDetailView(with: product) { [weak self] state in
            switch state {
            case true:
                self?.homeViewState?(.loading)
            case false:
                self?.homeViewState?(.done)
            }
        }
    }
}

enum HomeViewState {
    case loading
    case done
    case error
}
