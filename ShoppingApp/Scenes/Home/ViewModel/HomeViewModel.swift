//
//  HomeViewModel.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation
import NetworkLayer

typealias HomeViewStateBlock = (HomeViewState) -> Void

protocol HomeViewModelProtocol: DataProviderProtocol {
    var coordinator: HomeViewCoordinatorProtocol? { get }
    func getData()
    func subscribeHomeViewState(with completion: @escaping HomeViewStateBlock)
    func subscribeNetworkState()
    func navigateToBasket()
}

class HomeViewModel: HomeViewModelProtocol {
    var coordinator: HomeViewCoordinatorProtocol?
    var dataFormatter: HomeDataFormatterProtocol

    // View states
    var homeViewState: HomeViewStateBlock?

    // Managers
    var networkChecker: NetworkCheckerManager

    init(formatter: HomeDataFormatterProtocol,
         networkChecker: NetworkCheckerManager) {
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

    func subscribeHomeViewState(with completion: @escaping HomeViewStateBlock) {
        homeViewState = completion
    }

    func navigateToBasket() {
        coordinator?.navigateToBasketView()
    }

    private func apiCall(with urlRequest: URLRequest, completion: @escaping (Result<ProductResponse, Error>) -> Void) {
        APIManager.shared.executeRequest(urlRequest: urlRequest, completion: completion)
    }

    private lazy var dataListener: (Result<ProductResponse, Error>) -> Void = { [weak self] result in
        switch result {
        case .failure(let error):
            print("Error data listener: \(error)")
            self?.homeViewState?(.error)
            self?.dataResponseHandler(from: self?.dataFormatter.getItemsFromDisk())
        case .success(let response):
            print("data: \(response)")
            self?.dataFormatter.saveItems(from: response)
            self?.dataResponseHandler(from: self?.dataFormatter.getItemsFromDisk())
        }
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
extension HomeViewModel: DataProviderProtocol {
    func askNumberOfItem(in section: Int) -> Int {
        dataFormatter.getNumberOfItems(in: section) ?? 0
    }

    func askData(at index: Int) -> GenericDataProtocol? {
        dataFormatter.askData(at: index)
    }

    func selectedItem(at index: Int) {
        guard let product = dataFormatter.getItem(at: index) else { return }
        coordinator?.navigateToDetailView(with: product) { [self] state in
            switch state {
            case true:
                homeViewState?(.loading)
                dataResponseHandler(from: dataFormatter.getItemsFromDisk())
                homeViewState?(.done)
            case false:
                break
            }
        }
    }
}

enum HomeViewState {
    case loading
    case done
    case error
}
