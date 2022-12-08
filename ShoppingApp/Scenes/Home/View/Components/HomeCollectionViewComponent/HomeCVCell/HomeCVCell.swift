//
//  HomeCVCell.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import UIKit

final class HomeCVCell: BaseCollectionViewCell {
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
