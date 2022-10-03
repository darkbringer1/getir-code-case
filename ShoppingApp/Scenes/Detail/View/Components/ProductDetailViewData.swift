//
//  ProductDetailViewData.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import Foundation

class ProductDetailViewData {
    private(set) var headerViewData: ProductHeaderData?
    private(set) var displayerData: [ProductDetailDisplayerData] = [ProductDetailDisplayerData]()
    private(set) var footerViewData: ProductFooterData?

    func setCharacterDetailHeaderViewData(by value: ProductHeaderData) -> Self {
        headerViewData = value
        return self
    }

    func setTitleViewData(by value: [ProductDetailDisplayerData]) -> Self {
        displayerData = value
        return self
    }

    func setFooterViewData(by value: ProductFooterData) -> Self {
        footerViewData = value
        return self
    }
}
