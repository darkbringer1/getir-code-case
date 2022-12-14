//
//  HomeDataProviderProtocol.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation

protocol HomeDataProviderProtocol: AnyObject {
    func askNumberOfItem(in section: Int) -> Int
    func askData(at index: Int) -> GenericDataProtocol?
    func selectedItem(at index: Int)
}
