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
                   baseURL: EndpointManager.BaseURL.main.value,
                   path: EndpointManager.Paths.key.value,
                   data: request)
    }
}
