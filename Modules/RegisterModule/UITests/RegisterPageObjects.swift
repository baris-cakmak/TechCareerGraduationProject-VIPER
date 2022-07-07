//
//  RegisterPageObjects.swift
//  TechCareerGraduationProjectUITests
//
//  Created by Peace on 30.05.2022.
//

import XCTest
@testable import BaseKit
@testable import RegisterModule

final class RegisterPageObjects: BaseTest {
    lazy private(set) var cancelAlert = alert(.generalCancelAlert)
    lazy private(set) var cancelButton = alert(.generalCancelAlert).buttons.element(boundBy: 0)
    lazy private(set) var plusPhotoButton = button(.plusPhotoButton)
    lazy private(set) var emailTextField = textField(.emailTextField)
    lazy private(set) var passwordTextField = secureTextField(.passwordTextField)
    lazy private(set) var registerButton = button(.registerButton)
    lazy private(set) var doneButton = button(.keyboardToolbarDoneButton)
    lazy private(set) var choosePhotoButton = button(.chooseButton)
    lazy private(set) var usernameTextField = textField(.usernameTextField)
    lazy private(set) var navigationBackButton = buttonOf(elementQuery: app.navigationBars.buttons, identifier: .navigationBackButton)
    
    @discardableResult
    func tapCancel(completion: Completion = nil) -> Self {
        cancelButton
            .tap()
        return self
    }
    
    @discardableResult
    func type(
        _ text: String,
        intoTextField textField: XCUIElement,
        pressToRegister: Bool = false,
        completion: Completion = nil
    ) -> Self {
        textField.tap()
        textField.typeText(text)
        if doneButton.waitForExistence(timeout: 2) {
            doneButton.tap()
        }
        if pressToRegister {
            registerButton.tap()
        }
        return self
    }
    
    @discardableResult
    func choosePhoto(completion: Completion = nil) -> Self {
        if plusPhotoButton.waitForExistence(timeout: 5) {
            plusPhotoButton.tap()
        }
        if app.scrollViews.otherElements.images["Fotoğraf, 30 Mart 2018, ÖS 10:14"].waitForExistence(timeout: 3) {
            app.scrollViews.otherElements.images["Fotoğraf, 30 Mart 2018, ÖS 10:14"].tap()
        }
        if choosePhotoButton.waitForExistence(timeout: 2) {
            choosePhotoButton.tap()
        }
        return self
    }
    
    @discardableResult
    func tapRegister(completion: Completion = nil) -> Self {
        registerButton.tap()
        return self
    }
}
