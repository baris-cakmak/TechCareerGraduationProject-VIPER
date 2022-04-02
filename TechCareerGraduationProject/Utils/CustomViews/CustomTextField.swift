//
//  CustomTextFieldView.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 29.03.2022.
//

import UIKit

class CustomTextField: UITextField {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonConfiguration()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonConfiguration()

    }
    // MARK: - Method
    func commonConfiguration() {
        borderStyle = .none
        layer.cornerRadius = frame.size.height / 2

        layer.borderWidth = 0.3
        layer.borderColor = UIColor.black.cgColor

        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor.black.cgColor

        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: frame.height))
        leftView = paddingView
        leftViewMode = UITextField.ViewMode.always
    }

    
    
}
