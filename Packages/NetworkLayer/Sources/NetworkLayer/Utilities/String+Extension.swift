//
//  String+Extension.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation

extension String {
    func url() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkError.missingURL }
        return url
    }
}

extension String {
    func toLocalize() -> String{
        return NSLocalizedString(self, comment: "")
    }
}
