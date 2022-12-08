//
//  GenericCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import UIKit

class GenericCollectionViewCell<DataType, ViewType: GenericBaseView<DataType>>: BaseCollectionViewCell {

    lazy var genericView: ViewType = {
        let temp = ViewType()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        //added major view add method
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setupViews() {
        super.setupViews()

        contentView.addSubview(genericView)

        NSLayoutConstraint.activate([
            genericView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            genericView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            genericView.topAnchor.constraint(equalTo: contentView.topAnchor),
            genericView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

   func setRowData(data: DataType) {
        genericView.set(data: data)
    }
}
