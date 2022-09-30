//
//  APIManagerProtocol.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation

protocol APIManagerProtocol {
    func executeRequest<R: Codable>(urlRequest: URLRequest, completion: @escaping (Result<R, Error>) -> Void)
}
