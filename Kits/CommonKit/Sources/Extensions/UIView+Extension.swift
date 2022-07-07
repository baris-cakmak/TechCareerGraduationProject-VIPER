//
//  UIView+Extension.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 25.03.2022.
//

import UIKit

extension UIView {
    public func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = { (_: Bool) -> Void in }) {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: UIView.AnimationOptions.curveEaseIn,
            animations: {
                self.alpha = 1.0
            },
            completion: completion
        )
    }

    public func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = { (_: Bool) -> Void in }) {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: UIView.AnimationOptions.curveEaseIn,
            animations: {
                self.alpha = 0.0
            },
            completion: completion
        )
    }
}
