//
//  TechCareerGraduationProjectUITests.swift
//  TechCareerGraduationProjectUITests
//
//  Created by Peace on 29.05.2022.
//

import XCTest
@testable import RegisterModule

final class SignUpUITests: XCTestCase {
    let app = XCUIApplication.main()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testGoToRegisterScreenAndSelectPhoto() {
        app.launch()
        XCTAssertTrue(LoginPageObjects().goToSignUpButton.exists)
        LoginPageObjects().goToRegisterScreen()
        XCTAssertTrue(RegisterPageObjects().plusPhotoButton.exists)
        RegisterPageObjects().choosePhoto()
    }
    
    func testGoToRegisterScreen_ForgettingProfilePhotoSelection_ReturnAlertTrue() {
        app.launch()
        XCTAssertFalse(RegisterPageObjects().cancelAlert.isHittable)
        LoginPageObjects().goToRegisterScreen()
        RegisterPageObjects()
            .type(
                "email",
                intoTextField: RegisterPageObjects().emailTextField
            )
            .type(
                "password",
                intoTextField: RegisterPageObjects().passwordTextField
            )
            .type(
                "username",
                intoTextField: RegisterPageObjects().usernameTextField,
                pressToRegister: true
            )
        let predicate = NSPredicate(format: "label CONTAINS[c] 'nil'")
        let errorLabel = app.staticTexts.containing(predicate)
        XCTAssertTrue(errorLabel.element.exists)
        XCTAssertTrue(RegisterPageObjects().cancelAlert.isHittable)
    }
    
    func testGoToRegisterScreen_InvalidEmailTyped_ReturnAlertTrue() {
        app.launch()
        XCTAssertFalse(RegisterPageObjects().cancelAlert.isHittable)
        LoginPageObjects().goToRegisterScreen()
        RegisterPageObjects()
            .type(
                "em",
                intoTextField: RegisterPageObjects().emailTextField
            )
            .type(
                "password",
                intoTextField: RegisterPageObjects().passwordTextField
            )
            .type(
                "username",
                intoTextField: RegisterPageObjects().usernameTextField
            )
            .choosePhoto()
            .tapRegister()
        XCTAssertTrue(RegisterPageObjects().cancelAlert.isHittable)
    }
        
    func testGoToRegister_DoNotConformValidPassword_ReturnAlertTrue() {
        app.launch()
        LoginPageObjects().goToRegisterScreen()
        XCTAssertFalse(RegisterPageObjects().cancelAlert.isHittable)
        XCTAssertFalse(RegisterPageObjects().cancelAlert.exists)
        RegisterPageObjects()
            .choosePhoto()
            .type(
                "validemail@test.com",
                intoTextField: RegisterPageObjects().emailTextField
            )
            .type(
                "pas",
                intoTextField: RegisterPageObjects().passwordTextField
            )
            .type(
                "username",
                intoTextField: RegisterPageObjects().usernameTextField,
                pressToRegister: true
            )
        XCTAssertTrue(RegisterPageObjects().cancelAlert.exists)
        XCTAssertTrue(RegisterPageObjects().cancelAlert.isHittable)
    }
    
    func testGoToRegister_WhenTheNotDesiredUsernameEntered_ReturnAlertTrue() {
        app.launch()
        LoginPageObjects().goToRegisterScreen()
        RegisterPageObjects()
            .choosePhoto()
            .type(
                "validemail@test.com",
                intoTextField: RegisterPageObjects().emailTextField
            )
            .type(
                "Password123**",
                intoTextField: RegisterPageObjects().passwordTextField
            )
            .type(
                "us",
                intoTextField: RegisterPageObjects().usernameTextField,
                pressToRegister: true
            )
        XCTAssertTrue(RegisterPageObjects().cancelAlert.isHittable)
    }
}
