//
//  UIImage+Extension.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 29.04.2022.
//

import UIKit

extension UIImage {
    public static func named(_ name: String) -> UIImage {
        guard let image = UIImage(named: name) else {
            fatalError("Could not initialize \(UIImage.self) named \(name).")
        }
        return image
    }
}
