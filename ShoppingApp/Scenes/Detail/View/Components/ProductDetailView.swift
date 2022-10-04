//
//  ProductDetailView.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 3.10.2022.
//

import UIKit

final class ProductDetailView: GenericBaseView<ProductDetailViewData> {
    private lazy var collectionView: UICollectionView = {
        let layout = ProductHeaderFlowLayout()
        layout.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 500)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(ProductDetailCell.self, forCellWithReuseIdentifier: ProductDetailCell.identifier)
        collection.register(ProductHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProductHeaderReusableView.identifier)
        collection.register(ProductFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ProductFooterReusableView.identifier)
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

    private func setData(to header: ProductHeaderReusableView) {
        guard let data = returnData(), let headerViewData = data.headerViewData else { return }
        header.setRowData(data: headerViewData)
    }

    private func setData(to footer: ProductFooterReusableView) {
        guard let data = returnData(), let footerViewData = data.footerViewData else { return }
        footer.setRowData(data: footerViewData)
    }

    private func getItem(at index: IndexPath) -> ProductDetailDisplayerData {
        guard let data = returnData() else { fatalError("please provide data..")}
        return data.displayerData[index.row]
    }

    private func getNumberOfItems() -> Int {
        guard let data = returnData() else { return 0 }
        return data.displayerData.count
    }
}

extension ProductDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProductHeaderReusableView.identifier, for: indexPath) as? ProductHeaderReusableView else { return UICollectionReusableView() }
            setData(to: header)
            return header
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProductFooterReusableView.identifier, for: indexPath) as? ProductFooterReusableView else { return UICollectionReusableView() }
            setData(to: footer)
            return footer
        default:
            assert(false, "unexpected element kind")
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 340)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 140)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getNumberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailCell.identifier, for: indexPath) as? ProductDetailCell else { return UICollectionViewCell() }
        cell.setRowData(data: getItem(at: indexPath))
        return cell
    }
}
