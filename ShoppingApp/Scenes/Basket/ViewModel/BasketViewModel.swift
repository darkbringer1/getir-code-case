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
    func showOrderConfirmedAlert() -> Alert
    func subscribeOrderConfirmedListener(with completion: @escaping () -> Void)
}

final class BasketViewModel: BasketViewModelProtocol {
    private var shoppingListDataManager: ShoppingListCoreDataProtocol
    var coordinator: HomeViewCoordinatorProtocol?
    private var basketViewState: BasketViewStateBlock?
    var orderConfirmedButtonListener: (() -> Void)?

    init() {
        self.shoppingListDataManager = ShoppingListCoreDataManager()
        basketViewState?(.loading)
    }

    func subscribeOrderConfirmedListener(with completion: @escaping () -> Void) {
        orderConfirmedButtonListener = completion
    }

    func subscribeToViewStateListener(with completion: @escaping BasketViewStateBlock) {
        basketViewState = completion
    }

    func getCollectionViewData() -> BasketCollectionViewData {
        let data = BasketCollectionViewData(totalLabelText: getBasketTotal())
            .setTitleViewData(by: getBasketCellArray())
            .setbuyNowButtonAction(by: buyNowButtonPressed)
        basketViewState?(.done)
        return data
    }

    private func getBasketCellArray() -> [BasketCellDisplayerData] {
        let list = shoppingListDataManager.returnItemsFromCoreData().map({ BasketCellDisplayerData(product: $0) })
        let itemsInBasket = list.filter({ ($0.product.productCount ?? 0) > 0 })
        return itemsInBasket
    }

    lazy var buyNowButtonPressed: () -> Void = { [weak self] in
        print("SIPARIS ALINDI")
        guard let self = self else { return }
        self.orderConfirmedButtonListener?()
    }

    func showOrderConfirmedAlert() -> Alert {
            Alert(title: "Siparisiniz onaylandi!",
                  message: getBasketTotal(),
                  actions: [AlertAction(title: "Tamam",
                                        style: .default,
                                        action: .none)],
                  style: .alert)
    }

    private func getBasketTotal() -> String {
        let basket = getBasketCellArray()
        var totalBill: Double = 0
        basket.forEach { totalBill += Double($0.product.productCount ?? 1) * $0.product.productPrice }
        let totalBillText = "Sepet toplami: " + (totalBill.priceToString(with: "₺") ?? "0.00 ₺")
        return totalBillText
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
}
