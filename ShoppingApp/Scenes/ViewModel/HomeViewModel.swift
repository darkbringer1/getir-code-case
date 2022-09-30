//
//  HomeViewModel.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation
import NetworkLayer

protocol HomeViewModelProtocol {
    var coordinator: HomeViewCoordinatorProtocol? { get }
    func getData()
}

class HomeViewModel: HomeViewModelProtocol {
    var coordinator: HomeViewCoordinatorProtocol?
    func getData() {
        do {
            guard let urlRequest = try? ProductService(request: Request()).returnURLRequest() else { return }
            apiCall(with: urlRequest, completion: dataListener)
        }
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
        }
    }
}
