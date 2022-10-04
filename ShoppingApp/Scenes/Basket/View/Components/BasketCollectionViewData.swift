//
//  BasketCollectionViewData.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 4.10.2022.
//

import Foundation

final class BasketCollectionViewData {
    private(set) var displayerData: [BasketCellDisplayerData] = [BasketCellDisplayerData]()
    
    func setTitleViewData(by value: [BasketCellDisplayerData]) -> Self {
        displayerData = value
        return self
    }
}
