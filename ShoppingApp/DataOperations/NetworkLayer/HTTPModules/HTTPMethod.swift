//
//  HTTPMethod.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation

struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    static let delete = HTTPMethod(rawValue: "DELETE")
    static let get = HTTPMethod(rawValue: "GET")
    static let post = HTTPMethod(rawValue: "POST")
    static let put = HTTPMethod(rawValue: "PUT")

    let rawValue: String

    init(rawValue: String) {
        self.rawValue = rawValue
    }
}
