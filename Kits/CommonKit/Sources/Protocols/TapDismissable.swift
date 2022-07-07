//
//  TapDismissable.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 6.05.2022.
//

import UIKit

public protocol TapDismissable: AnyObject {
    var tapGesture: UITapGestureRecognizer? { get set }
    func configureTapGesture()
}

extension TapDismissable where Self: UIViewController {
    public func configureTapGesture() {
        tapGesture = .init(
            target: view,
            action: #selector(UIView.endEditing)
        )
        // swiftlint: disable force_unwrapping
        view.addGestureRecognizer(tapGesture!)
    }
}
