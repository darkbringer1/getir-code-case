//
//  ProductFooterView.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import UIKit

class ProductFooterView: GenericBaseView<ProductFooterData> {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [topStackView, addToShoppingList])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.axis = .vertical
        temp.distribution = .fill
        temp.alignment = .fill
        temp.contentMode = .center
        temp.spacing = 20
        return temp
    }()

    private lazy var topStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [title, plusMinusStack])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.axis = .horizontal
        temp.distribution = .fillEqually
        temp.alignment = .fill
        temp.contentMode = .center
        temp.layer.cornerRadius = 6
        temp.clipsToBounds = true
        temp.backgroundColor = .systemTeal
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

    private lazy var plusMinusStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [minusButton, countLabel, plusButton])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.axis = .horizontal
        temp.alignment = .fill
        temp.distribution = .fillEqually
        temp.contentMode = .scaleAspectFill
        return temp
    }()

    private lazy var plusButton: UIButton = {
        let temp = UIButton()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        temp.tintColor = .black
        return temp
    }()

    private lazy var minusButton: UIButton = {
        let temp = UIButton()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        temp.tintColor = .black
        return temp
    }()

    private lazy var countLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.text = " "
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 1
        temp.contentMode = .center
        temp.textAlignment = .center
        return temp
    }()

    private lazy var addToShoppingList: UIButton = {
        let temp = UIButton()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.setTitle("Sepete Ekle", for: .normal)
        temp.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
        temp.tintColor = .black
        temp.setTitleColor(UIColor.black, for: .normal)
        temp.layer.borderWidth = 2
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
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),

            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            addToShoppingList.heightAnchor.constraint(equalToConstant: 48),
            topStackView.heightAnchor.constraint(equalToConstant: 48),
            title.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
    }

    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() else { return }
        title.text = data.title
        countLabel.text = "\(data.count)"
        plusButton.addTarget(nil, action: #selector(addPlusTap), for: .touchUpInside)
        minusButton.addTarget(nil, action: #selector(addMinusTap), for: .touchUpInside)
        addToShoppingList.addTarget(nil, action: #selector(addToShoppingListTap), for: .touchUpInside)
    }

    @objc func addPlusTap() {
        guard let data = returnData() else { return }
        data.plusButtonAction?()
    }

    @objc func addMinusTap() {
        guard let data = returnData() else { return }
        data.minusButtonAction?()
    }

    @objc func addToShoppingListTap() {
        guard let data = returnData() else { return }
        data.addToShoppingListAction?()
    }
}
