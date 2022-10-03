//
//  HomeCellDisplayerData.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation

class HomeCellDisplayerData: GenericDataProtocol {
    private(set) var productImageData: String
    private(set) var productName: String
    private(set) var productPrice: Double
    private(set) var productDescription: String

    init(productImageData: String,
         productName: String,
         productPrice: Double,
         productDescription: String) {
        self.productImageData = productImageData
        self.productName = productName
        self.productPrice = productPrice
        self.productDescription = productDescription
    }
}
