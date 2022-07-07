//
//  CustomTextFieldView.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 29.03.2022.
//

import UIKit
// MARK: - CustomTextFieldDelegate

public typealias CustomTextFieldInterfaces = BackButtonHiddenable & ViewFrameChangable

public protocol CustomTextFieldDelegate: AnyObject, CustomTextFieldInterfaces {
    var activeTextField: UITextField? { get set }
    func keyboardWillShow(notification: Notification)
    func keyboardWillHide(notification: Notification)
    func didDoneToolbarTapped(_ textField: UITextField)
    func hideNavigationItemBackButtonItem(_ hide: Bool, animated: Bool)
    func setOriginYPointOfTheView(with yPoint: Float)
    func didKeyboardResultsCalculated(_ textField: UITextField, keyboardHeight: Float, bottomOfTheTextField: Float, viewHeight: Float)
}

public final class CustomTextField: UITextField {
    // MARK: - Init
    public weak var customDelegate: CustomTextFieldDelegate?
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonConfiguration()
        addDoneToolbar()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonConfiguration()
        addDoneToolbar()
    }
}

// MARK: - Constant
private enum CustomTextFieldConstants {
    enum Layout {
        static let borderWidth: CGFloat = 0.3
        static let borderColor: CGColor = UIColor.black.cgColor
        static let shadowOpacity: Float = 1
        static let shadowRadius: CGFloat = 4
        static let shadowOffset: CGSize = .init(width: .zero, height: 5)
        static let shadowColor: CGColor = UIColor.black.cgColor
        /// To not have any constraint error giving static frame to the toolbar must be done
        static let toolbarSize: CGRect = .init(x: .zero, y: .zero, width: 100, height: 100)
    }
}
// MARK: - Helper
extension CustomTextField {
    func commonConfiguration() {
        borderStyle = .none
        layer.cornerRadius = frame.size.height / 2

        layer.borderWidth = CustomTextFieldConstants.Layout.borderWidth
        layer.borderColor = CustomTextFieldConstants.Layout.borderColor

        layer.shadowOpacity = CustomTextFieldConstants.Layout.shadowOpacity
        layer.shadowRadius = CustomTextFieldConstants.Layout.shadowRadius
        layer.shadowOffset = CustomTextFieldConstants.Layout.shadowOffset
        layer.shadowColor = CustomTextFieldConstants.Layout.shadowColor

        let paddingView: UIView = .init(frame: .init(x: .zero, y: .zero, width: 20, height: frame.height))
        leftView = paddingView
        leftViewMode = UITextField.ViewMode.always
        autocorrectionType = .no
        spellCheckingType = .no
    }
    func addDoneToolbar() {
        let toolbar = UIToolbar(frame: CustomTextFieldConstants.Layout.toolbarSize)
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didDoneToolbarButtonTapped)
        )
        doneButton.isAccessibilityElement = true
        doneButton.accessibilityIdentifier = AccessibilityIdentifiers.Buttons.keyboardToolbarDoneButton.rawValue
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        toolbar.sizeToFit()

        inputAccessoryView = toolbar
    }
}
// MARK: - Action
extension CustomTextField {
    @objc func didDoneToolbarButtonTapped() {
        customDelegate?.didDoneToolbarTapped(self)
    }
}
// MARK: - CustomTextFieldDelegate
extension CustomTextFieldDelegate where Self: UIViewController {
    public func didDoneToolbarTapped(_ textField: UITextField) {
        self.view.endEditing(true)
    }

    public func keyboardWillShow(notification: Notification) {
        guard let activeTextField = activeTextField, let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let bottomOfTheTextField: Float = .init(activeTextField.convert(activeTextField.bounds, to: self.view).maxY)
        let viewHeight: Float = .init(self.view.frame.height)
        let keyboardHeight: Float = .init(keyboardSize.height)
        didKeyboardResultsCalculated(
            activeTextField,
            keyboardHeight: keyboardHeight,
            bottomOfTheTextField: bottomOfTheTextField,
            viewHeight: viewHeight
        )
    }

    public func keyboardWillHide(notification: Notification) {
        setOriginYPointOfTheView(with: .zero)
        hideNavigationItemBackButtonItem(false, animated: false)
    }
}
// MARK: - TextFieldDelegate Default Imp
extension CustomTextField: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        customDelegate?.activeTextField = textField
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        customDelegate?.activeTextField = nil
    }
}
