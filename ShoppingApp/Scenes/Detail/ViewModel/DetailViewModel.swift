//
//  DetailViewModel.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import Foundation
typealias DetailDataState = (Product) -> Void
typealias DetailDataChangeBlock = (DetailChangeState) -> Void
typealias AddToBasketStateBlock = (Bool) -> Void

protocol DetailViewModelProtocol {
    func getProductData()
    func detailDataState(with completion: @escaping DetailDataState)
    func formatData() -> ProductDetailViewData
    func detailDataChangeListener(with completion: @escaping DetailDataChangeBlock)
    func addToBasketListener(with completion: @escaping AddToBasketStateBlock)
    func showAddedToBasketAlert() -> Alert
}

final class DetailViewModel: DetailViewModelProtocol {
    var coordinator: HomeViewCoordinatorProtocol?
    var productData: Product
    var dataState: DetailDataState?
    var detailDataChange: DetailDataChangeBlock?
    var addToBasketState: AddToBasketStateBlock?
    private var coreDataManager = CoreDataManager.shared
    private var shoppingListDataManager: ShoppingListCoreDataManager


    init(productData: Product, addToBasket: @escaping AddToBasketStateBlock) {
        self.productData = productData
        self.shoppingListDataManager = ShoppingListCoreDataManager()
        if self.productData.productCount == nil {
            self.productData.productCount = 0
        }
    }

    func getProductData() {
        dataState?(productData)
    }

    func addToBasketListener(with completion: @escaping AddToBasketStateBlock) {
        addToBasketState = completion
    }

    func detailDataState(with completion: @escaping DetailDataState) {
        dataState = completion
    }
    
    func detailDataChangeListener(with completion: @escaping DetailDataChangeBlock) {
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

    private lazy var plusButtonHandler: () -> Void = { [weak self] in
        print("Add button pressed")
        self?.productData.productCount? += Int16(1)
        self?.detailDataChange?(.dataChanged)
    }

    private lazy var minusButtonHandler: () -> Void = { [weak self] in
        print("Substract button pressed")
        if self?.productData.productCount ?? 0 > 0 {
            self?.productData.productCount? -= Int16(1)
        }
        self?.detailDataChange?(.dataChanged)
    }

    private lazy var addToShoppingListHandler: () -> Void = { [weak self] in
        print("Add to shopping list tapped")
        self?.updateProduct()
        self?.addToBasketState?(true)
    }

    private func getProductFooterData() -> ProductFooterData {
       ProductFooterData(title: productData.productPrice.priceToString(with: "₺") ?? "0.0 ₺")
            .setPlusButtonAction(by: plusButtonHandler)
            .setMinusButtonAction(by: minusButtonHandler)
            .setAddToShoppingListAction(by: addToShoppingListHandler)
            .setCountData(by: Int(productData.productCount ?? 0))
    }

    func showAddedToBasketAlert() -> Alert {
        Alert(title: "Urun sepete eklendi",
              message: "",
              actions: [AlertAction(title: "Tamam",
                                    style: .default,
                                    action: .none)],
              style: .alert)
    }

    private func updateProduct() {
        shoppingListDataManager.updateEntity(shoppingItem: productData)
    }
}

enum DetailChangeState {
    case dataChanged
    case dataStable
}
