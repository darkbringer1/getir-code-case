//
//  CustomImageViewData.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import UIKit

final class CustomImageViewData {
    private(set) var imageUrl: String
    private(set) var contentMode: UIView.ContentMode = .scaleAspectFit
    private(set) var loadingType: CustomImageLoadingType = .memory
    private(set) var imageId: String?

    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }

    func setLoadingType(by value: CustomImageLoadingType) -> Self {
        self.loadingType = value
        return self
    }

    func setContentMode(by value: UIView.ContentMode) -> Self {
        self.contentMode = value
        return self
    }

    func setImageId(by value: String) -> Self {
        self.imageId = value
        return self
    }
}
