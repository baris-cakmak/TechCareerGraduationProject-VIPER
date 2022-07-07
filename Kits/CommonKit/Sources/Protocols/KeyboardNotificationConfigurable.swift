//
//  KeyboardNotificationConfigurable.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 4.06.2022.
//

import UIKit

public protocol KeyboardNotificationConfigurable {
    func configureKeyboardNotifications()
}

extension KeyboardNotificationConfigurable where Self: CustomTextFieldDelegate {
    public func configureKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardWillShow(notification: notification)
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardWillHide(notification: notification)
        }
    }
}
