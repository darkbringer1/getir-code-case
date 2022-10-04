//
//  ShoppingListCoreDataManager.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 2.10.2022.
//

import Foundation

protocol ShoppingListCoreDataProtocol {
    func saveToCoreData(cartList: Array<Product>)
    func updateEntity(shoppingItem: Product)
}

class ShoppingListCoreDataManager: ShoppingListCoreDataProtocol {

    private var coreDataManager: CoreDataManager!
    private var listEntities = Array<ShoppingListEntity>()

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
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
            
            if let ob = coreDataManager.fetchWithPredicate(ShoppingListEntity.self, predicateKey: "productImage", predicateValue: shoppingItem.productImage) {
                ob.productName = shoppingItem.productName
                ob.productImage = shoppingItem.productImage
                ob.productPrice = shoppingItem.productPrice
                ob.productDescription = shoppingItem.productDescription

                if let productId = shoppingItem.productId {
                    ob.productId = productId
                }
                if let productCount = shoppingItem.productCount {
                    ob.productCount = productCount
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
        print("DEINIT CartOperationsCoreDataManager")
    }
}
