//
//  ProductDetailDisplayerData.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import Foundation

final class ProductDetailDisplayerData {
    private(set) var title: String
    private(set) var descriptionText: String

    init(title: String, descriptionText: String) {
        self.title = title
        self.descriptionText = descriptionText
    }
}
