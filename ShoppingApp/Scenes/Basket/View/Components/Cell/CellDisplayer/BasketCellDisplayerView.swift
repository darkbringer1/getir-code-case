//
//  BasketCellDisplayerView.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 4.10.2022.
//

import UIKit

class BasketCellDisplayerView: GenericBaseView<BasketCellDisplayerData> {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.backgroundColor = .systemMint
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [imageContainer, nameAndCountStack, priceLabel])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.alignment = .center
        temp.distribution = .fill
        temp.contentMode = .scaleToFill
        temp.axis = .horizontal
        temp.spacing = 5
        return temp
    }()

    private lazy var imageContainer: CustomImageViewComponent = {
        let temp = CustomImageViewComponent()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.contentMode = .scaleAspectFit
        return temp
    }()

    private lazy var nameAndCountStack: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [productName, productCount])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.alignment = .fill
        temp.distribution = .fill
        temp.axis = .vertical
        temp.spacing = 5
        return temp
    }()

    private lazy var productCount: UILabel = {
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

    private lazy var productName: UILabel = {
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

    private lazy var priceLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.text = " "
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .right
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
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            imageContainer.heightAnchor.constraint(equalToConstant: 50),
            imageContainer.widthAnchor.constraint(equalToConstant: 50),
        ])
    }

    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() else { return }
        productName.text = data.product.productName
        let count = Double(data.product.productCount ?? 0)
        productCount.text = "Adet sayisi: \(Int(count))"
        priceLabel.text = (data.product.productPrice * count).priceToString(with: "₺")
        imageContainer.setData(componentData: CustomImageViewData(imageUrl: parseImageUrl(from: data.product.productImage)))
    }

    private func parseImageUrl(from urlString: String) -> String {
        guard let imageUrl = URL(string: urlString) else { return "" }
        var components = URLComponents()
        components.scheme = "https"
        components.host = "raw.githubusercontent.com"
        var urlPathComponents = [String]()
        imageUrl.pathComponents.forEach { path in
            if path != "blob" {
                urlPathComponents.append(path)
            }
        }
        components.path = urlPathComponents.joined(separator: "/")
        return components.url?.absoluteString ?? ""
    }
}
