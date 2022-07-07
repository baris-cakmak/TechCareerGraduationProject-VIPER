//
//  LoginPageObjects.swift
//  TechCareerGraduationProjectUITests
//
//  Created by Peace on 30.05.2022.
//

import XCTest
@testable import BaseKit
@testable import RegisterModule

final class LoginPageObjects: BaseTest {
    lazy private(set) var goToSignUpButton = button(.goToSignUpButton)
    
    @discardableResult func goToRegisterScreen(completion: Completion = nil) -> Self {
        goToSignUpButton.tap()
        return self
    }
}
