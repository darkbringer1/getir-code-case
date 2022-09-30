//
//  HomeCVCell.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import UIKit

class HomeCVCell: BaseCollectionViewCell {

    private lazy var displayerView: HomeCellDisplayerView = {
        let temp = HomeCellDisplayerView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()

    override func setupViews() {
        super.setupViews()
        addContentDisplayer()
    }

    private func addContentDisplayer() {
        contentView.addSubview(displayerView)

        NSLayoutConstraint.activate([
            displayerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            displayerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            displayerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            displayerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func set(data: GenericDataProtocol) {
        displayerView.set(data: data)
    }
}

extension HomeCVCell {
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

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
}
