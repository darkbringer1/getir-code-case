//
//  ShoppingListCoreDataManager.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 2.10.2022.
//

import Foundation

protocol ShoppingListCoreDataProtocol {
    var coreDataManager: CoreDataManager { get set }
    func saveToCoreData(cartList: Array<Product>)
    func updateEntity(shoppingItem: Product)
    func returnItemsFromCoreData() -> ProductResponse
    func deleteItems()
}

final class ShoppingListCoreDataManager: ShoppingListCoreDataProtocol {
    var coreDataManager: CoreDataManager
    private var listEntities = Array<ShoppingListEntity>()

    init() {
        self.coreDataManager = CoreDataManager.shared
    }


    func returnItemsFromCoreData() -> ProductResponse {
        fetchCartList()
        let list: ProductResponse = listEntities.compactMap { Product(
            productName: $0.productName ?? "",
            productDescription: $0.productDescription ?? "",
            productPrice: $0.productPrice,
            productImage: $0.productImage ?? "",
            productId: $0.productId,
            productCount: $0.productCount
        )}
        return list
    }

    func updateEntity(shoppingItem: Product) {
        fetchCartList()
        if checkCartListProductExist(product: shoppingItem) {
            
            if let object = coreDataManager.fetchWithPredicate(ShoppingListEntity.self, predicateKey: "productImage", predicateValue: shoppingItem.productImage) {
                object.productName = shoppingItem.productName
                object.productImage = shoppingItem.productImage
                object.productPrice = shoppingItem.productPrice
                object.productDescription = shoppingItem.productDescription

                if let productId = shoppingItem.productId {
                    object.productId = productId
                }
                if let productCount = shoppingItem.productCount {
                    object.productCount = productCount
                }
            }
            coreDataManager.saveContext()
        }
        fetchCartList()
    }

    func saveToCoreData(cartList: Array<Product>) {

        fetchCartList()
        cartList.forEach { (product) in

            if !checkCartListProductExist(product: product) {
                let object = ShoppingListEntity(context: coreDataManager.context)

                object.productName = product.productName
                object.productImage = product.productImage
                object.productPrice = product.productPrice
                object.productDescription = product.productDescription

                if let productId = product.productId {
                    object.productId = productId
                }
                if let productCount = product.productCount {
                    object.productCount = productCount
                }
                coreDataManager.saveContext()
            }
        }
    }

    func deleteItems() {
        fetchCartList()
        listEntities.forEach { item in
            coreDataManager.context.delete(item)
        }
    }

    private func checkCartListProductExist(product: Product) -> Bool {
        listEntities.contains { (entity) -> Bool in
            if entity.productImage == product.productImage {
                return true
            } else {
                return false
            }
        }
    }

    private func fetchCartList() {
        listEntities.removeAll()
        listEntities = coreDataManager.fetch(ShoppingListEntity.self)
    }

    deinit {
        print("DEINIT ShoppingListCoreDataManager")
    }
}
