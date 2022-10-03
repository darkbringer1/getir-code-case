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
                self?.apiCallHandler(from: self?.dataFormatter.getItemsFromDisk())
            }
        }
    }

    func subscribeHomeViewState(with completion: @escaping HomeViewStateBlock) {
        homeViewState = completion
    }

    private func apiCall(with urlRequest: URLRequest, completion: @escaping (Result<ProductResponse, Error>) -> Void) {
        APIManager.shared.executeRequest(urlRequest: urlRequest, completion: completion)
    }

    private lazy var dataListener: (Result<ProductResponse, Error>) -> Void = { [weak self] result in
        switch result {
        case .failure(let error):
            print("Error data listener: \(error)")
            self?.homeViewState?(.error)
            self?.apiCallHandler(from: self?.dataFormatter.getItemsFromDisk())
        case .success(let response):
            print("data: \(response)")
            self?.dataFormatter.saveItems(from: response)
            self?.apiCallHandler(from: response)
        }
    }

    private func apiCallHandler(from response: ProductResponse?) {
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
        coordinator?.navigateToDetailView(with: product)
    }
}

// MARK: - CoreDataOps
extension HomeViewModel {
}

enum HomeViewState {
    case loading
    case done
    case error
}
