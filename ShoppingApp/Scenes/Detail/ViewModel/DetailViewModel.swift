//
//  DetailViewModel.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import Foundation
typealias DetailDataState = (Product) -> Void
typealias DetailDataChangeBlock = (DetailChangeState) -> Void

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

    init(productData: Product) {
        self.productData = productData
        if self.productData.productCount == nil {
            self.productData.productCount = 0
        }
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

    lazy var plusButtonHandler: () -> Void = {
        print("Add button pressed")
        self.productData.productCount? += Int16(1)
        self.detailDataChange?(.dataChanged)
    }

    lazy var minusButtonHandler: () -> Void = {
        print("Substract button pressed")
        if self.productData.productCount ?? 0 > 0 {
            self.productData.productCount? -= Int16(1)
        }
        self.detailDataChange?(.dataChanged)
    }

    lazy var addToShoppingListHandler: () -> Void = {
        print("Add to shopping list tapped")
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
