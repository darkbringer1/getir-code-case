//
//  BasketViewModel.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 4.10.2022.
//

import Foundation

protocol BasketViewModelProtocol: BasketCVDataProvider {
    func getCollectionViewData() -> BasketCollectionViewData
}

class BasketViewModel: BasketViewModelProtocol {
    private var coreDataManager = CoreDataManager.shared
    private var shoppingListDataManager: ShoppingListCoreDataManager
    var coordinator: HomeViewCoordinatorProtocol?

    init() {
        self.shoppingListDataManager = ShoppingListCoreDataManager(coreDataManager: coreDataManager)
    }

    func getCollectionViewData() -> BasketCollectionViewData {
        return BasketCollectionViewData().setTitleViewData(by: getBasketCellArray())
    }

    private func getBasketCellArray() -> [BasketCellDisplayerData] {
        let list = shoppingListDataManager.returnItemsFromCoreData().map({ BasketCellDisplayerData(product: $0) })
        let itemsInBasket = list.filter({ ($0.product.productCount ?? 0) > 0 })
        return itemsInBasket
    }
}

extension BasketViewModel: BasketCVDataProvider {
    func didSelect(product: Product) {
        coordinator?.navigateToDetailView(with: product)
    }
}
