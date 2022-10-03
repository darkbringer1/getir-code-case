//
//  BasketViewController.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 4.10.2022.
//

import UIKit

class BasketViewController: UIViewController {
    var viewModel: BasketViewModelProtocol!

    convenience init(viewModel: BasketViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
    }
}
