//
//  ProductResponse.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation

typealias ProductResponse = [Product]

struct Product: Codable {
    let productName, productDescription: String
    let productPrice: Double
    let productImage: String
}
