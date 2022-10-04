//
//  HomeCVComponent.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import Foundation
import UIKit

final class HomeCVComponent: GenericBaseView<HomeCVData> {
    weak var dataProvider: HomeDataProviderProtocol?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coll.translatesAutoresizingMaskIntoConstraints = false
        coll.backgroundColor = .clear
        coll.delegate = self
        coll.dataSource = self
        coll.register(HomeCVCell.self, forCellWithReuseIdentifier: HomeCVCell.identifier)
        coll.contentInsetAdjustmentBehavior = .always
        return coll
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
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension HomeCVComponent: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataProvider?.askNumberOfItem(in: section) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCVCell.identifier, for: indexPath) as? HomeCVCell,
              let data = dataProvider?.askData(at: indexPath.row) else { return UICollectionViewCell() }
        cell.set(data: data)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dataProvider?.selectedItem(at: indexPath.row)
    }
}

extension HomeCVComponent: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 40) / 2
        let height = (UIScreen.main.bounds.height) / 3
        return CGSize(width: width, height: height)
    }
}
