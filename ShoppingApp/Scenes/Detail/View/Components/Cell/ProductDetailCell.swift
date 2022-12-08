//
//  ProductDetailCell.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import UIKit

final class ProductDetailCell: GenericCollectionViewCell<ProductDetailDisplayerData, ProductDetailDisplayerView> {
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        var targetSize = targetSize
        targetSize.height = CGFloat.greatestFiniteMagnitude

        let size = super.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        return size
    }
}
