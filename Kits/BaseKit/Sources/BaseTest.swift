//
//  BaseTest.swift
//  TechCareerGraduationProjectUITests
//
//  Created by Peace on 30.05.2022.
//

import XCTest
import CommonKit

public class BaseTest {
    public let app = XCUIApplication.main()
    typealias Completion = (() -> Void)?
    // Button
    public func button(_ identifier: AccessibilityIdentifiers.Buttons) -> XCUIElement {
        app.buttons[identifier.rawValue]
    }
    
    public func buttonOf(elementQuery: XCUIElementQuery, identifier: AccessibilityIdentifiers.Buttons) -> XCUIElement {
        elementQuery[identifier.rawValue]
    }
    
    // TextField
    public func textField(_ identifier: AccessibilityIdentifiers.TextFields) -> XCUIElement {
        app.textFields[identifier.rawValue]
    }
    
    // SecureTextField
    public func secureTextField(_ identifier: AccessibilityIdentifiers.SecureTextFields) -> XCUIElement {
        app.secureTextFields[identifier.rawValue]
    }
    
    // Alert
    public func alert(_ identifier: AccessibilityIdentifiers.Alerts) -> XCUIElement {
        app.alerts[identifier.rawValue]
    }
}
