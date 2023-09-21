//
//  UICollectionView.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit

public extension UICollectionView {
    func registerSupplementaryHeaderView<T: Reusable>(_ viewType: T.Type) where T: UICollectionReusableView {
        register(
            viewType,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: viewType.reuseID
        )
    }

    func registerCellClass<T: Reusable>(_ cellType: T.Type) where T: UICollectionViewCell {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseID)
    }

    func dequeueReusableCell<T: Reusable>(
        ofType cellType: T.Type,
        at indexPath: IndexPath
    ) -> T where T: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath) as? T else {
            fatalError("❌ Failed attempt find  cell wit identifier \(cellType.reuseID)!")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T: Reusable>(
        ofType viewType: T.Type,
        at indexPath: IndexPath,
        kind: String
    ) -> T where T: UICollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: viewType.reuseID,
            for: indexPath
        ) as? T else {
            fatalError("❌ Failed attempt find  ReusableSupplementaryView \(viewType.reuseID)!")
        }
        return view
    }
}
