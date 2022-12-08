//
//  NetworkError.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation

public enum NetworkError : String, Error {
    case nilParameters = "nil parameters."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "nil URL."
}
