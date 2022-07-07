//
//  AlertPresentable.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 2.05.2022.
//

import UIKit

private enum AlertPresentableConstants {
    static let alertControllerTitle = "Error"
    static let cancelActionTitle = "Cancel"
}

public protocol AlertPresentable {
    var navigationController: UINavigationController? { get }
    func showAlert(message: String)
}

extension AlertPresentable {
    public func showAlert(message: String) {
        let ac = UIAlertController(title: AlertPresentableConstants.alertControllerTitle, message: message, preferredStyle: .alert)
        ac.view.accessibilityIdentifier = AccessibilityIdentifiers.Alerts.generalCancelAlert.rawValue
        ac.addAction(UIAlertAction(title: AlertPresentableConstants.cancelActionTitle, style: .cancel, handler: nil))
        navigationController?.present(ac, animated: true)
    }
}
