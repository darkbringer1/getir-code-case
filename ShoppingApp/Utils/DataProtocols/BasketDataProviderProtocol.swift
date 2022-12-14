//
//  BasketDataProviderProtocol.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 4.10.2022.
//

import Foundation

protocol BasketDataProviderProtocol: AnyObject {
    func didSelect(product: Product)
}
