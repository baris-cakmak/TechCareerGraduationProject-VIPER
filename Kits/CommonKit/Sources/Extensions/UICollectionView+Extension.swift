//
//  UICollectionView+Extension.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 8.05.2022.
//

import UIKit

extension UICollectionView {
    public func registerWithNib<T: UICollectionViewCell>(_ cell: T.Type, bundle: Bundle) {
        register(UINib(nibName: T.reuseIdentifier, bundle: bundle), forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    public func register<T: UICollectionViewCell>(_ cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    public func registerSupplementaryView<T: UICollectionReusableView>(_ view: T.Type, kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
    }
    public func registerSupplementaryViewWithNib<T: UICollectionReusableView>(_ view: T.Type, kind: String, bundle: Bundle) {
        let nib = UINib(nibName: T.identifier, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
    }
    public func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    public func dequeueSupplementaryView<T: UICollectionReusableView>(ofKind: String, for indexPath: IndexPath, type: T.Type) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
}
