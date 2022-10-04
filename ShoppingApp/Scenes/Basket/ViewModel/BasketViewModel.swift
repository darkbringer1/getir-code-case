//
//  BasketViewModel.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 4.10.2022.
//

import Foundation
typealias BasketViewStateBlock = (BasketViewState) -> Void

protocol BasketViewModelProtocol: BasketDataProviderProtocol {
    func getCollectionViewData() -> BasketCollectionViewData
    func subscribeToViewStateListener(with completion: @escaping BasketViewStateBlock)
}

final class BasketViewModel: BasketViewModelProtocol {
    private var shoppingListDataManager: ShoppingListCoreDataProtocol
    var coordinator: HomeViewCoordinatorProtocol?
    private var basketViewState: BasketViewStateBlock?

    init() {
        self.shoppingListDataManager = ShoppingListCoreDataManager()
        basketViewState?(.loading)
    }

    func subscribeToViewStateListener(with completion: @escaping BasketViewStateBlock) {
        basketViewState = completion
    }

    func getCollectionViewData() -> BasketCollectionViewData {
        let data = BasketCollectionViewData().setTitleViewData(by: getBasketCellArray())
        basketViewState?(.done)
        return data
    }

    private func getBasketCellArray() -> [BasketCellDisplayerData] {
        let list = shoppingListDataManager.returnItemsFromCoreData().map({ BasketCellDisplayerData(product: $0) })
        let itemsInBasket = list.filter({ ($0.product.productCount ?? 0) > 0 })
        return itemsInBasket
    }
}

extension BasketViewModel: BasketDataProviderProtocol {
    func didSelect(product: Product) {
        coordinator?.navigateToDetailView(with: product) { [weak self] state in
            switch state {
            case true:
                self?.basketViewState?(.loading)
            case false:
                self?.basketViewState?(.done)
            }
        }
    }
}

enum BasketViewState {
    case loading
    case done
    case error(Alert)
}
