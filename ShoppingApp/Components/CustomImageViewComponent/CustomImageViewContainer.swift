//
//  CustomImageViewContainer.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation
import UIKit

class CustomImageViewContainer: GenericBaseView<CustomImageViewData> {

    private lazy var customImageView: CustomImageViewComponent = {
        let temp = CustomImageViewComponent()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.image = UIImage(named: "placeholder")
        temp.contentMode = .scaleAspectFit
        return temp
    }()

    override func setupViews() {
        super.setupViews()
        addCustomImageView()
    }

    private func addCustomImageView() {
        addSubview(customImageView)

        NSLayoutConstraint.activate([
            customImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customImageView.topAnchor.constraint(equalTo: topAnchor),
            customImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() else { return }
        DispatchQueue.main.async {
            self.customImageView.setData(componentData: data)
            self.customImageView.contentMode = data.contentMode
        }
    }

}
