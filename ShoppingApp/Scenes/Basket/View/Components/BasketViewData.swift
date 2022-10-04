//
//  BasketViewData.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 4.10.2022.
//

import Foundation

final class BasketViewData {
    typealias VoidHandler = () -> Void

    private(set) var displayerData: [BasketCellDisplayerData] = [BasketCellDisplayerData]()
    private(set) var buyNowButtonAction: VoidHandler?
    private(set) var totalLabelText: String
    
    init(totalLabelText: String) {
        self.totalLabelText = totalLabelText
    }
    func setTitleViewData(by value: [BasketCellDisplayerData]) -> Self {
        displayerData = value
        return self
    }

    func setbuyNowButtonAction(by value: VoidHandler?) -> Self {
        buyNowButtonAction = value
        return self
    }
}
