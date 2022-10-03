//
//  ProductHeaderView.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import UIKit

class ProductHeaderView: GenericBaseView<ProductHeaderData> {

    private lazy var imageContainer: CustomImageViewContainer = {
        let image = CustomImageViewContainer()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 2
        image.clipsToBounds = true
        return image
    }()

    override func setupViews() {
        super.setupViews()
        addComponents()
    }

    private func addComponents() {
        addSubview(imageContainer)

        NSLayoutConstraint.activate([

            imageContainer.topAnchor.constraint(equalTo: topAnchor),
            imageContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: trailingAnchor),

        ])
    }

    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() else { return }
        imageContainer.set(data: CustomImageViewData(imageUrl: parseImageUrl(from: data.imageUrl)))
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
