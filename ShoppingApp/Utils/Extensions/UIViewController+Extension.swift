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

    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
