//
//  ProductDetailDisplayerView.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import UIKit

final class ProductDetailDisplayerView: GenericBaseView<ProductDetailDisplayerData> {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [title, descriptionLabel])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.alignment = .fill
        temp.distribution = .fill
        temp.axis = .vertical
        temp.spacing = 5
        return temp
    }()

    private lazy var title: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.text = " "
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .left
        return temp
    }()

    private lazy var descriptionLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.text = " "
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .left
        return temp
    }()

    override func setupViews() {
        super.setupViews()
        addComponents()
    }

    private func addComponents() {
        addSubview(containerView)
        containerView.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),

            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
    }

    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() else { return }
        title.text = data.title
        descriptionLabel.text = data.descriptionText
    }
}
