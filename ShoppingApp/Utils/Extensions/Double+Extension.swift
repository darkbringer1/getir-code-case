//
//  Double+Extension.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation

// MARK: - Price Formatting
public extension Double {

    // Creating a formatter is expensive, so we should do it only once.
    static var priceFormatter: NumberFormatter?

    /// Returns formatted percentage
    var formattedPercentage: String {
        return String(format: "%%%.f", self)
    }

    /// Returns price without currency
    var formattedPrice: String? {
        return priceToString(with: nil)
    }

    /// Formatting price with currency
    ///
    /// - Parameter currency: Currency String
    /// - Returns: Returns formatted price with currency
    func priceToString(with currency: String?) -> String? {
        if Double.priceFormatter == nil {
            Double.priceFormatter = NumberFormatter()
            Double.priceFormatter?.numberStyle = .decimal
            Double.priceFormatter?.minimumFractionDigits = 2
            Double.priceFormatter?.maximumFractionDigits = 2
            Double.priceFormatter?.decimalSeparator = ","
            Double.priceFormatter?.groupingSeparator = "."
        }

        var price: String = Double.priceFormatter?.string(from: self as NSNumber) ?? ""
        if let currency = currency, !currency.isEmpty {
            price = "\(price) \(currency)"
        }
        return price
    }
}
