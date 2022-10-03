//
//  UIControl+Extension.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import UIKit

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping ()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}
