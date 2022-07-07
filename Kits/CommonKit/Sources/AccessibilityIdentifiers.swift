//
//  AccessibilityIdentifiers.swift
//  TechCareerGraduationProjectUITests
//
//  Created by Peace on 30.05.2022.
//

import Foundation

public enum AccessibilityIdentifiers {
    public enum Buttons: String {
        case plusPhotoButton
        case registerButton
        case goToSignUpButton
        case keyboardToolbarDoneButton = "doneButton"
        case chooseButton = "Done"
        case navigationBackButton = "Back"
    }
    public enum TextFields: String {
        case emailTextField
        case usernameTextField
    }
    public enum Alerts: String {
        case generalCancelAlert
    }
    public enum SecureTextFields: String {
        case passwordTextField
    }
}
