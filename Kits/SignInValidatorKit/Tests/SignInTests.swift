//
//  SignInTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 7.06.2022.
//

import XCTest
@testable import SignInValidatorKit

final class SignInTests: XCTestCase {
    var sut: SignInValidator!
    
    func createSignInValidator(signInModel: SignInModel) {
        sut = .init(signInModel: signInModel)
    }
    
    override func setUp() {
        super.setUp()
        sut = .init(signInModel: nil)
    }
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
        
    func testSignInValidator_WhenSignInInputIsNil_DoNotThrowAnError() {
        XCTAssertNoThrow(try sut.validateAll())
    }

    func testSignInValidator_WhenEmailFieldIsMissing_ThrowMissingFieldError() {
        createSignInValidator(signInModel: .init(email: "", password: "password"))
        XCTAssertThrowsError(try sut.validateAll())
        XCTAssertThrowsError(try sut.validateAll(), SignInErrors.missingField.localizedDescription) { _ in
            // might print error or any other localized error stuff
        }
    }

    func testSignInValidator_WhenPasswordFieldIsMissing_ThrowMissingFieldError() {
        createSignInValidator(signInModel: .init(email: "email", password: ""))
        XCTAssertThrowsError(try sut.validateAll())
        XCTAssertThrowsError(try sut.validateAll(), SignInErrors.missingField.localizedDescription) { _ in
        }
    }

    func testSignInValidator_WhenEmailAndPasswordFieldsAreFilled_NoThrowError() {
        createSignInValidator(signInModel: .init(email: "email", password: "password"))
        XCTAssertNoThrow(try sut.validateAll())
    }
}
