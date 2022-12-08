//
//  EndpointManager.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation
typealias BaseUrl = EndpointManager.BaseURL
typealias Path = EndpointManager.Paths

enum EndpointManager {

    enum BaseURL: GenericValueProtocol {

        typealias Value = String

        case main
        var value: String {
            switch self {
            case .main:
                return "https://mocki.io/v1"
            }
        }
    }

    enum Paths: GenericValueProtocol {
        typealias Value = String

        case key

        var value: String {
            switch self {
            case .key:
                return "6bb59bbc-e757-4e71-9267-2fee84658ff2"
            }
        }
    }
}

public protocol GenericValueProtocol {

    associatedtype Value
    var value: Value { get }

}
