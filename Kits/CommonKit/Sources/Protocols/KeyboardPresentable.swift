//
//  KeyboardPresentable.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 2.06.2022.
//

import Foundation

public protocol KeyboardPresentable {
    func handleTappedTextFieldToDecideOnViewFrameChange(keyboardHeight: Float, bottomOfTheTextField: Float, viewHeight: Float)
    func changeOriginYPointOfView(with yValue: Float, hideBackButton: Bool, animated: Bool)
    func moveBackToDefaultYPoint(hideBackButton: Bool, animated: Bool)
}

extension KeyboardPresentable {
    public func handleTappedTextFieldToDecideOnViewFrameChange(keyboardHeight: Float, bottomOfTheTextField: Float, viewHeight: Float) {
        let topOfTheKeyboard = viewHeight - keyboardHeight

        if bottomOfTheTextField > topOfTheKeyboard && abs(bottomOfTheTextField - topOfTheKeyboard) > 30 {
            let movingValue = .zero - keyboardHeight
            changeOriginYPointOfView(with: movingValue, hideBackButton: true, animated: true)
        } else {
            moveBackToDefaultYPoint(hideBackButton: false, animated: true)
        }
    }
}
