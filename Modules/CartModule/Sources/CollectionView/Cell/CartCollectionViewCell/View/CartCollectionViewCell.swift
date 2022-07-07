//
//  CartCollectionViewCell.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 25.03.2022.
//

import UIKit
import GMStepper
import SDWebImage
import CommonKit

// MARK: - Question.. Not inhering an uicollectionviewcell or if let as? Uıcollectionviewcell..
protocol CartCollectionViewCellInterface: UICollectionViewCell {
    func configureCellAppearance()
    func configureMealNameLabel(_ text: String)
    func configureStepperView(currentValue: Double, leftButtonText: String)
    func configureMealImageView(with url: URL)
    func configureMealDescriptionLabel(_ text: String)
    func configurePriceLabel(_ text: String)
}

final class CartCollectionViewCell: UICollectionViewCell, CartCollectionViewCellInterface {
    // MARK: - UI Properties
    @IBOutlet weak private var mealNameLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var stepperView: GMStepper!
    @IBOutlet weak private var mealImageView: UIImageView!
    @IBOutlet weak private var mealDescriptionLabel: UILabel!
    
    // MARK: - Presenter
    var presenter: CartCellPresenterInterface? {
        didSet {
            presenter?.cellDidLoad()
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Constant
extension CartCollectionViewCell {
    private enum CellConstant {
        static let cornerRadius: CGFloat = 30.0
        static let stepperValue: Double = 1.0
        static let stepperMinimumValue: Double = 0.0
        static let stepperMaximumValue: Double = 100.0
        static let stepperStepValue: Double = 1.0
        static let stepperLeftButtonText: String = "-"
        static let stepperRightButonText: String = "+"
        static let stepperButtonsTextColor: UIColor = .secondaryLabel
        static let stepperButtonsBackgroundColor: UIColor = .named("blurBackground")
        static let stepperLabelTextColor: UIColor = .named("stepperLabelColor")
        static let stepperLabelBackgroundColor: UIColor = .clear
        static let stepperCornerRadius: CGFloat = 5.0
        static let stepperLabelWidthWeight: CGFloat = 0.4
        static let stepperLimitAnimationColor: UIColor = .named("stepperLabelColor")
        static let stepperAutoRepeat = false
    }
}
// MARK: - Helper
extension CartCollectionViewCell {
    private func configureStepperView() {
        stepperView.value = CellConstant.stepperValue
        stepperView.minimumValue = CellConstant.stepperMinimumValue
        stepperView.maximumValue = CellConstant.stepperMaximumValue
        stepperView.stepValue = CellConstant.stepperStepValue
        stepperView.autorepeat = CellConstant.stepperAutoRepeat
        stepperView.leftButtonText = CellConstant.stepperLeftButtonText
        stepperView.rightButtonText = CellConstant.stepperRightButonText
        stepperView.buttonsTextColor = CellConstant.stepperButtonsTextColor
        stepperView.buttonsBackgroundColor = CellConstant.stepperButtonsBackgroundColor
        stepperView.labelTextColor = CellConstant.stepperLabelTextColor
        stepperView.labelBackgroundColor = CellConstant.stepperLabelBackgroundColor
        stepperView.labelFont = Constants.Font.tooGeneralFont
        stepperView.cornerRadius = CellConstant.stepperCornerRadius
        stepperView.labelWidthWeight = CellConstant.stepperLabelWidthWeight
        stepperView.limitHitAnimationColor = CellConstant.stepperLimitAnimationColor
        stepperView.addTarget(self, action: #selector(didTapStepperButtons), for: .valueChanged)
    }
}
// MARK: - Action
extension CartCollectionViewCell {
    @objc
    private func didTapStepperButtons() {
        presenter?.didStepperValueChanged(for: self, stepperView.value)
    }
    @IBAction private func didTapDeleteButtton(_ sender: UIButton) {
        presenter?.deleteMeal(for: self)
    }
}
// MARK: - CartCollectionViewCellInterface
extension CartCollectionViewCell {
    func configureCellAppearance() {
        layer.cornerRadius = CellConstant.cornerRadius
        configureStepperView()
    }
    func configureMealNameLabel(_ text: String) {
        mealNameLabel.text = text
    }
    func configureStepperView(currentValue: Double, leftButtonText: String = CellConstant.stepperLeftButtonText) {
        stepperView.value = currentValue
        stepperView.leftButtonText = leftButtonText
    }
    func configureMealImageView(with url: URL) {
        mealImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        mealImageView.sd_setImage(with: url)
    }
    func configureMealDescriptionLabel(_ text: String) {
        mealDescriptionLabel.text = text
    }
    func configurePriceLabel(_ text: String) {
        priceLabel.text = text
    }
}
