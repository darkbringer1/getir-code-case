//
//  DetailViewController.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var viewModel: DetailViewModelProtocol!

    convenience init(viewModel: DetailViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint

    }
}
