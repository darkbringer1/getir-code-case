//
//  ProductFooterData.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import Foundation

class ProductFooterData {
    typealias VoidHandler = () -> Void
    private(set) var title: String = " "
    private(set) var count: Int = 0
    private(set) var plusButtonAction: VoidHandler? = nil
    private(set) var minusButtonAction: VoidHandler? = nil
    private(set) var addToShoppingListAction: VoidHandler? = nil

    init(title: String) {
        self.title = title
    }

    func setCountData(by value: Int) -> Self {
        count = value
        return self
    }

//    func setTitle(by value: String) -> Self {
//        title = value
//        return self
//    }

    func setPlusButtonAction(by value: VoidHandler?) -> Self {
        plusButtonAction = value
        return self
    }

    func setMinusButtonAction(by value: VoidHandler?) -> Self {
        minusButtonAction = value
        return self
    }

    func setAddToShoppingListAction(by value: VoidHandler?) -> Self {
        addToShoppingListAction = value
        return self
    }
}
