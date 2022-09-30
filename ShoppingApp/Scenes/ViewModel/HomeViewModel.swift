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
}

class HomeViewModel: HomeViewModelProtocol {
    var coordinator: HomeViewCoordinatorProtocol?
    var dataFormatter: HomeDataFormatterProtocol
    var homeViewState: HomeViewStateBlock?

    init(formatter: HomeDataFormatterProtocol) {
        self.dataFormatter = formatter
    }

    func getData() {
        homeViewState?(.loading)
        do {
            guard let urlRequest = try? ProductService(request: Request()).returnURLRequest() else { return }
            apiCall(with: urlRequest, completion: dataListener)
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
        case .success(let response):
            print("data: \(response)")
            self?.apiCallHandler(from: response)
        }
    }

    private func apiCallHandler(from response: ProductResponse) {
        dataFormatter.setData(with: response)
        homeViewState?(.done)
    }
}

extension HomeViewModel: DataProviderProtocol {
    func askNumberOfItem(in section: Int) -> Int {
        dataFormatter.getNumberOfItems(in: section) ?? 0
    }

    func askData(at index: Int) -> GenericDataProtocol? {
        dataFormatter.askData(at: index)
    }

    func selectedItem(at index: Int) {
        debugPrint(dataFormatter.getItem(at: index))
    }
}

enum HomeViewState {
    case loading
    case done
    case error
}
