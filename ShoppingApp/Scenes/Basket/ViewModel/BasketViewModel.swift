//
//  BasketViewModel.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 4.10.2022.
//

import Foundation
typealias BasketViewStateBlock = (BasketViewState) -> Void

protocol BasketViewModelProtocol: BasketDataProviderProtocol {
    func getCollectionViewData() -> BasketViewData
    func viewStateListener(with completion: @escaping BasketViewStateBlock)
    func showOrderConfirmedAlert(action: @escaping () -> Void) -> Alert
    func orderConfirmedListener(with completion: @escaping () -> Void)
}

final class BasketViewModel: BasketViewModelProtocol {
    var shoppingListDataManager: ShoppingListCoreDataProtocol?
    var coordinator: HomeViewCoordinatorProtocol?
    private var basketViewState: BasketViewStateBlock?
    private var orderConfirmedButtonListener: (() -> Void)?

    init() {
        basketViewState?(.loading)
    }

    func orderConfirmedListener(with completion: @escaping () -> Void) {
        orderConfirmedButtonListener = completion
    }

    func viewStateListener(with completion: @escaping BasketViewStateBlock) {
        basketViewState = completion
    }

    func getCollectionViewData() -> BasketViewData {
        let data = BasketViewData(totalLabelText: getBasketTotal())
            .setTitleViewData(by: getBasketCellArray())
            .setbuyNowButtonAction(by: buyNowButtonPressed)
        basketViewState?(.done)
        return data
    }

    func showOrderConfirmedAlert(action: @escaping () -> Void) -> Alert {
        Alert(title: "Siparisiniz onaylandi!",
              message: getBasketTotal(),
              actions: [AlertAction(title: "Tamam",
                                    style: .default,
                                    action: action())],
              style: .alert)
    }

    private func getBasketCellArray() -> [BasketCellDisplayerData] {
        guard let list = shoppingListDataManager?.getBasketItems() else { return [] }
        return list.compactMap({ BasketCellDisplayerData(product: $0) })
    }

    private lazy var buyNowButtonPressed: () -> Void = { [weak self] in
        guard let self = self else { return }
        self.orderConfirmedButtonListener?()
        self.shoppingListDataManager?.removeAllOrders()
        self.basketViewState?(.loading)
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
