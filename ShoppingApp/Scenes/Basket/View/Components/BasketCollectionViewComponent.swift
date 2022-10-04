//
//  BasketCollectionViewComponent.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 4.10.2022.
//

import UIKit

final class BasketCollectionViewComponent: GenericBaseView<BasketCollectionViewData> {
    var dataProvider: BasketDataProviderProtocol?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 500)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(BasketViewCell.self, forCellWithReuseIdentifier: BasketViewCell.identifier)
        return collection
    }()

    private lazy var bottomContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.backgroundColor = .systemMint
        return view
    }()
    private lazy var bottomStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [totalLabel, buyNowButton])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.alignment = .fill
        temp.distribution = .fill
        temp.contentMode = .scaleToFill
        temp.axis = .vertical
        temp.spacing = 15
        return temp
    }()

    private lazy var totalLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.text = " "
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .center
        return temp
    }()

    private lazy var buyNowButton: UIButton = {
        let temp = UIButton()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.setTitle("Sepeti onayla", for: .normal)
        temp.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
        temp.tintColor = .black
        temp.setTitleColor(UIColor.black, for: .normal)
        temp.layer.borderWidth = 2
        return temp
    }()

    override func setupViews() {
        super.setupViews()
        addCollectionView()
    }

    private func addCollectionView() {
        addSubview(collectionView)
        addSubview(bottomContainerView)
        bottomContainerView.addSubview(bottomStackView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomContainerView.topAnchor),

            bottomContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomContainerView.heightAnchor.constraint(equalToConstant: 150),

            bottomStackView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 16),
            bottomStackView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 16),
            bottomStackView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -16),
            buyNowButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        bringSubviewToFront(bottomContainerView)
    }

    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    private func getItem(at index: IndexPath) -> BasketCellDisplayerData {
        guard let data = returnData() else { fatalError("please provide data..")}
        return data.displayerData[index.row]
    }

    private func getNumberOfItems() -> Int {
        guard let data = returnData() else { return 0 }
        return data.displayerData.count
    }

    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() else { return }
        totalLabel.text = data.totalLabelText
        buyNowButton.addTarget(nil, action: #selector(buyNowTap), for: .touchUpInside)
    }

    @objc func buyNowTap() {
        guard let data = returnData() else { return }
        data.buyNowButtonAction?()
    }
}

extension BasketCollectionViewComponent: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        getNumberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketViewCell.identifier, for: indexPath) as? BasketViewCell else { return UICollectionViewCell() }
        cell.setRowData(data: getItem(at: indexPath))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataProvider?.didSelect(product: getItem(at: indexPath).product)
    }
}

extension BasketCollectionViewComponent: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 40)
        let height = (UIScreen.main.bounds.height) / 5
        return CGSize(width: width, height: height)
    }
}
