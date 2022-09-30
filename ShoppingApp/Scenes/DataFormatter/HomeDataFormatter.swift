//
//  HomeDataFormatter.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation
protocol HomeDataFormatterProtocol {
    func setData(with response: ProductResponse?)
    func getNumberOfItems(in section: Int) -> Int?
    func getItem(at index: Int) -> Product?
    func askData(at index: Int) -> GenericDataProtocol?
}

class HomeDataFormatter: HomeDataFormatterProtocol {
    private var data: ProductResponse?

    func setData(with response: ProductResponse?) {
        data = response
    }

    func getNumberOfItems(in section: Int) -> Int? {
        data?.count
    }

    func getItem(at index: Int) -> Product? {
        data?[index]
    }

    func askData(at index: Int) -> GenericDataProtocol? {
        guard let product = data.map({ $0[index] }) else { return nil }
        return HomeCellDisplayerData(productImageData: product.productImage,
                                     productName: product.productName,
                                     productPrice: product.productPrice,
                                     productDescription: product.productDescription)
    }
}
