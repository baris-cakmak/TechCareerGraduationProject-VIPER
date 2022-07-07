//
//  SignUpTests.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 24.05.2022.
//

import XCTest
@testable import SignUpValidatorKit

final class SignUpTests: XCTestCase {
    var sut: SignUpValidator!
    override func setUp() {
        sut = .init(signUpModel: .init(email: "peace@gmail.com", passwordOne: "Baris123*", passwordTwo: "Baris123*", username: "ASDASD"))
    }
    override func tearDown() {
        sut = nil
    }
    
    func testSignUpValidator_WhenEmailLengthIsShorterThanDesiredLimit_ShouldThrowAnError() {
        let emails = ["peac", "peac@test.com", "Peac"]
   
        do {
            try emails.forEach { email in
            XCTAssertThrowsError(try sut.emailLongerThanMinLetterCount(email: email))
            }
        } catch {
            XCTFail("there is an error occured in some of the emails")
        }
    }
    
    func testSignUpValidator_WhenEmailLengthIsLongerThanMinLength_NoThrowAnError() {
        let email = "email"
        XCTAssertNoThrow(try sut.emailLongerThanMinLetterCount(email: email))
    }
    
    func testSignUpValidator_WhenUsernameIsShorterThanMinLength_ThrowsAnError() {
        let username = "u"
        XCTAssertThrowsError(try sut.usernameDoesNotViolatesMinLength(username: username))
    }
    
    func testSignUpValidator_WhenUsernameIsLongerThanSpecified_ThrowsAnError() {
        let username = "peacepeacepeace"
        XCTAssertThrowsError(try sut.usernameDoesNotViolatesMaxLength(username: username))
    }
    
    func testSignUpValidator_WhenPasswordsDoNotMatch_ThrowsAnError() {
        let passwordOne = "Password"
        let passwordTwo = "Passwor"
        
        XCTAssertThrowsError(try sut.passwordsMatch(firstPassword: passwordOne, secondPassword: passwordTwo))
    }
    
    func testSignUpValidator_WhenPasswordIsOkayWithTheSpecifiedRegexPattern_NotThrowAnError() {
        let password = "Peace123*"
        XCTAssertNoThrow(try sut.passwordValid(password: password))
    }
    
    func testSignUpValidator_WhenPasswordsDoNotMatch_ThrowAnError() {
        let passwordOne = "password"
        let passwordTwo = "password"
        
        XCTAssertNoThrow(try sut.passwordsMatch(firstPassword: passwordOne, secondPassword: passwordTwo))
    }
    
    func testSignUpValidator_WhenAnyOfTheFieldIsEmptyThrowsAnError() {
        let signUpModels: [SignUpModel] = [
            .init(email: "", passwordOne: "aa", passwordTwo: "aaa", username: "aa"),
            .init(email: "aa", passwordOne: "", passwordTwo: "aa", username: "aa"),
            .init(email: "aa", passwordOne: "aa", passwordTwo: "aa", username: ""),
            .init(email: "a", passwordOne: "a", passwordTwo: "", username: "a"),
            .init(email: "", passwordOne: "", passwordTwo: "", username: "")
        ]
        do {
            try signUpModels.forEach { signUpModel in
                XCTAssertThrowsError(try sut.fieldIsNotMissing(signUpModel: signUpModel))
            }
        } catch {
            XCTFail("failed")
        }
    }
    func testSignUpValidator_WhenAllTheFieldsFilled_NoThrowAnError() {
        let signUpModel: SignUpModel = .init(email: "a", passwordOne: "s", passwordTwo: "d", username: "v")
        XCTAssertNoThrow(try sut.fieldIsNotMissing(signUpModel: signUpModel))
    }
    
    func testSignUpValidator_TryEveryValidatorSuccessfully_NoThrowAnError() {
        XCTAssertNoThrow(try sut.validateAll())
    }
}
