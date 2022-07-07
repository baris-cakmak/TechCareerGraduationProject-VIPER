//
//  NavigationItemUpdatable.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 8.05.2022.
//

import UIKit

public protocol NavigationItemUpdatable {
    func setNavigationItemTitle(with title: String)
}
extension NavigationItemUpdatable where Self: UIViewController {
    public func setNavigationItemTitle(with title: String) {
        navigationItem.title = title
    }
}
