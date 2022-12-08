//
//  HomeDataFormatter.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation
protocol HomeDataFormatterProtocol: AnyObject {
    func setData(with response: ProductResponse?)
    func getNumberOfItems(in section: Int) -> Int?
    func getItem(at index: Int) -> Product?
    func askData(at index: Int) -> GenericDataProtocol?
    func saveItems(from products: [Product])
    func getItemsFromDisk() -> ProductResponse?
    func getBasketItemCount() -> Int?
}

final class HomeDataFormatter: HomeDataFormatterProtocol {
    private var data: ProductResponse?
    private var shoppingListDataManager: ShoppingListCoreDataProtocol

    init(shoppingListCoreDataManager: ShoppingListCoreDataProtocol) {
        self.shoppingListDataManager = shoppingListCoreDataManager
    }

    func setData(with response: ProductResponse?) {
        data = response
    }

    func getNumberOfItems(in section: Int) -> Int? {
        data?.count
    }

    func getItem(at index: Int) -> Product? {
        let items = getItemsFromDisk()
        return items?[index]
    }

    func askData(at index: Int) -> GenericDataProtocol? {
        guard let product = data.map({ $0[index] }) else { return nil }
        return HomeCellDisplayerData(productImageData: product.productImage,
                                     productName: product.productName,
                                     productPrice: product.productPrice,
                                     productDescription: product.productDescription)
    }

    func saveItems(from products: [Product]) {
        shoppingListDataManager.saveToCoreData(cartList: products)
    }

    func getItemsFromDisk() -> ProductResponse? {
        shoppingListDataManager.returnItemsFromCoreData()
    }

    func getBasketItemCount() -> Int? {
        shoppingListDataManager.getBasketItems().count
    }
}
