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
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(BasketViewCell.self, forCellWithReuseIdentifier: BasketViewCell.identifier)
        return collection
    }()

    override func setupViews() {
        super.setupViews()
        addCollectionView()
    }

    private func addCollectionView() {
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
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
