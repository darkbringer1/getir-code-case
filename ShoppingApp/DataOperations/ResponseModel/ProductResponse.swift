//
//  ProductResponse.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation

typealias ProductResponse = [Product]

struct Product: Codable {
    var productName, productDescription: String
    var productPrice: Double
    var productImage: String
    var productId: String?
    var productCount: Int16?
}
