//
//  ProductService.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation
import NetworkLayer

class ProductService: APIServiceProvider<Request> {
    init(request: Request) {
        super.init(method: .get,
                   baseURL: "https://mocki.io/v1/6bb59bbc-e757-4e71-9267-2fee84658ff2",
                   path: nil,
                   data: request)
    }
}
