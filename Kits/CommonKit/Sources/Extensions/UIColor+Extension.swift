//
//  UIColor+Extension.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 29.04.2022.
//

import UIKit

extension UIColor {
    public static func named(_ name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            fatalError("Could not initialize \(UIColor.self) named \(name).")
        }
        return color
    }
}
