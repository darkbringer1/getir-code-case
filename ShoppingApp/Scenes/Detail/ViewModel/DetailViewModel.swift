//
//  DetailViewModel.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import Foundation
typealias DetailDataState = (Product) -> Void
typealias DetailDataChangeBlock = (DetailChangeState) -> Void
typealias NewItemAddBlock = (Bool) -> Void
protocol DetailViewModelProtocol {
    func getProductData()
    func subscribeDetailDataState(with completion: @escaping DetailDataState)
    func formatData() -> ProductDetailViewData
    func subscribeDetailDataChangeListener(with completion: @escaping DetailDataChangeBlock)

}

class DetailViewModel: DetailViewModelProtocol {
    var coordinator: HomeViewCoordinatorProtocol?
    var productData: Product
    var dataState: DetailDataState?
    var detailDataChange: DetailDataChangeBlock?
    var newItemChangeState: NewItemAddBlock?
    private var coreDataManager = CoreDataManager.shared
    private var shoppingListDataManager: ShoppingListCoreDataManager


    init(productData: Product, newItemAdded: NewItemAddBlock?) {
        self.productData = productData
        self.shoppingListDataManager = ShoppingListCoreDataManager(coreDataManager: coreDataManager)
        if self.productData.productCount == nil {
            self.productData.productCount = 0
        }
        self.newItemChangeState = newItemAdded
    }

    func getProductData() {
        dataState?(productData)
    }

    func subscribeDetailDataState(with completion: @escaping DetailDataState) {
        dataState = completion
    }
    
    func subscribeDetailDataChangeListener(with completion: @escaping DetailDataChangeBlock) {
        detailDataChange = completion
    }

    func formatData() -> ProductDetailViewData {
        let detailData = ProductDetailViewData()
            .setCharacterDetailHeaderViewData(by: ProductHeaderData(imageUrl: productData.productImage))
            .setTitleViewData(by: [ProductDetailDisplayerData(title: productData.productName,
                                                              descriptionText: productData.productDescription)])
            .setFooterViewData(by: getProductFooterData())
        detailDataChange?(.dataStable)
        return detailData
    }

    private lazy var plusButtonHandler: () -> Void = {
        print("Add button pressed")
        self.productData.productCount? += Int16(1)
        self.detailDataChange?(.dataChanged)
    }

    private lazy var minusButtonHandler: () -> Void = {
        print("Substract button pressed")
        if self.productData.productCount ?? 0 > 0 {
            self.productData.productCount? -= Int16(1)
        }
        self.detailDataChange?(.dataChanged)
    }

    private lazy var addToShoppingListHandler: () -> Void = {
        print("Add to shopping list tapped")
        self.shoppingListDataManager.updateEntity(shoppingItem: self.productData)
        self.newItemChangeState?(true)
    }

    private func getProductFooterData() -> ProductFooterData {
       ProductFooterData(title: productData.productPrice.priceToString(with: "₺") ?? "0.0 ₺")
            .setPlusButtonAction(by: plusButtonHandler)
            .setMinusButtonAction(by: minusButtonHandler)
            .setAddToShoppingListAction(by: addToShoppingListHandler)
            .setCountData(by: Int(productData.productCount ?? 0))
    }
}

enum DetailChangeState {
    case dataChanged
    case dataStable
}
