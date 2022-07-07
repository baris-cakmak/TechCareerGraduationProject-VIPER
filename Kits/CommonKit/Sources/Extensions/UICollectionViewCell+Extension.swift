//
//  UICollectionView+Extension.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 23.03.2022.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
}
