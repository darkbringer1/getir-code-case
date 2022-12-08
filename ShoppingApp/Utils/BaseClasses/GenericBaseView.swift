//
//  GenericBaseView.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import UIKit

class GenericBaseView<T>: UIView {

    private var data: T?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    init(frame: CGRect = .zero, data: T? = nil) {
        self.data = data
        super.init(frame: frame)
        setupViews()
        loadDataView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    func set(data: T?) {
        self.data = data
        loadDataView()
    }

    func returnData() -> T? {
        return data
    }

    func setupViews() {}

    func loadDataView() {}
}
