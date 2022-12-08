//
//  UIViewController+Extension.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 4.10.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func addDefaultBackBarButton(tapGesture: @escaping () -> Void) {
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        backButton.setImage(UIImage(systemName: "arrow.left.circle"), for: .normal)
        backButton.addAction(tapGesture)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    func addRightBarButton(imageSystemName: String, tapGesture: @escaping () -> Void) {
        let rightButtonView = UIButton(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        rightButtonView.setImage(UIImage(systemName: imageSystemName), for: .normal)
        rightButtonView.addAction(tapGesture)
        rightButtonView.tintColor = .systemMint
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButtonView)
    }

    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
