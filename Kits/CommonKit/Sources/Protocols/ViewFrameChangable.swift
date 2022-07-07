//
//  ViewFrameChangable.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.06.2022.
//

import UIKit

private enum ViewFrameChangableConstants {
    enum Animation {
        static let durationSetOriginYPoint: TimeInterval = 1.0
        static let delaySetOriginYPpoint: TimeInterval = 0.1
        static let dampingRationSetOriginYPoint: CGFloat = 0.6
        static let initialDampingSetOriginYPonit: CGFloat = 0.5
    }
}

public protocol ViewFrameChangable {
    func setOriginYPointOfTheView(with yPoint: Float)
}

extension ViewFrameChangable where Self: UIViewController {
    public func setOriginYPointOfTheView(with yPoint: Float) {
        UIView.animate(
            withDuration: ViewFrameChangableConstants.Animation.durationSetOriginYPoint,
            delay: ViewFrameChangableConstants.Animation.delaySetOriginYPpoint,
            usingSpringWithDamping: ViewFrameChangableConstants.Animation.dampingRationSetOriginYPoint,
            initialSpringVelocity: ViewFrameChangableConstants.Animation.initialDampingSetOriginYPonit,
            options: .curveEaseInOut
        ) {
            self.view.frame.origin.y = CGFloat(yPoint)
        }
    }
}
