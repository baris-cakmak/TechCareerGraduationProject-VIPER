//
//  BackButtonHiddenable.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.06.2022.
//

import UIKit

public protocol BackButtonHiddenable {
    func hideNavigationItemBackButtonItem(_ hide: Bool, animated: Bool)
}

extension BackButtonHiddenable where Self: UIViewController {
    public func hideNavigationItemBackButtonItem(_ hide: Bool, animated: Bool) {
        self.navigationItem.setHidesBackButton(hide, animated: animated)
    }
}
