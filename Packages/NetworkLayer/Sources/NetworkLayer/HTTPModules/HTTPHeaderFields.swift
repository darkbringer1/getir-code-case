//
//  HTTPHeaderFields.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation

public enum HTTPHeaderFields {

    case contentType

    var value: (String, String) {
        switch self {
        case .contentType:
            return ("Content-Type", "application/json")
        }
    }
}
