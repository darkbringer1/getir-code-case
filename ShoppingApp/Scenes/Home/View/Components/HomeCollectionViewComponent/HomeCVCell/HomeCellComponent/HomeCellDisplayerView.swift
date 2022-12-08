//
//  HomeCellDisplayerView.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import UIKit

final class HomeCellDisplayerView: GenericBaseView<GenericDataProtocol> {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        view.backgroundColor = .cyan
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageContainer, infoView, priceLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = true
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()

    private lazy var imageContainer: CustomImageViewContainer = {
        let image = CustomImageViewContainer()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var infoView: UILabel = {
        let info = UILabel()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.font = UIFont.boldSystemFont(ofSize: 14)
        info.textColor = .black
        info.text = " "
        info.contentMode = .top
        info.textAlignment = .center
        info.numberOfLines = 0
        return info
    }()

    private lazy var priceLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        temp.textColor = .black
        temp.text = " "
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

            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() as? HomeCellDisplayerData else { return }
        imageContainer.set(data: CustomImageViewData(imageUrl: parseImageUrl(from: data.productImageData)))
        infoView.text = data.productName
        priceLabel.text = data.productPrice.priceToString(with: "₺")
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

/*
    from: https://github.com/android-getir/public-files/blob/main/images/60ad26592af303bcbf206148_b64a8058-ef7e-43ec-9214-71130b5ba1a4.jpeg/
    to: https://raw.githubusercontent.com/android-getir/public-files/main/images/60ad26592af303bcbf206148_b64a8058-ef7e-43ec-9214-71130b5ba1a4.jpeg
*/
