//
//  CustomBlurView.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 24.03.2022.
//

import UIKit

@IBDesignable
class CustomBlurView: UIVisualEffectView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.cornerCurve = .continuous
            layer.masksToBounds = true
        }
    }
    
    
}
