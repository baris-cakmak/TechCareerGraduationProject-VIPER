//
//  HomeDetailViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 23.03.2022.
//

import UIKit
import GMStepper
import SDWebImage
import CommonKit

protocol HomeDetailPresenterOutputInterface: AnyObject {
    func configureStepperView()
    func configureMealNameLabel(_ text: String)
    func configurePriceLabel(_ text: String)
    func configureDescriptionLabel(_ text: String)
    func configureMealImageView(with url: URL)
    func setBackgroundColor()
    func didPriceChanged(price: String)
}

final class HomeDetailViewController: UIViewController {
    // MARK: - UI Properties
    @IBOutlet weak private var mealImageView: UIImageView!
    @IBOutlet weak private var stepper: GMStepper!
    @IBOutlet weak private var mealNameLabel: UILabel!
    @IBOutlet weak private var mealDescriptionLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var individualPriceLabel: UILabel!
    
    // MARK: - Presenter
    var presenter: HomeDetailPresenterInterface?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
// MARK: - Constant
extension HomeDetailViewController {
    private enum HomeViewConstants {
        static let priceLabelFadeDuration: TimeInterval = 0.5
        static let priceLabelFadeDelay: TimeInterval = 0
        static let backgroundColor: UIColor = .systemIndigo
        static let stepperValue: Double = 1.0
        static let stepperMinimumValue: Double = 1.0
        static let stepperMaximumValue: Double = 100.0
        static let stepperStepValue: Double = 1.0
        static let stepperAutoRepeat = true
        static let stepperLeftButtonText: String = "➖"
        static let stepperRightButtonText: String = "➕"
        static let stepperButtonsBackgroundColor: UIColor = .named("blurBackground")
        static let stepperLabelTextColor: UIColor = .named("stepperLabelColor")
        static let stepperLabelBackgroundColor: UIColor = .clear
        static let stepperCornerRadius: CGFloat = 20.0
        static let stepperLabelWidthWeight: CGFloat = 0.4
        static let stepperAnimationColor: UIColor = .named("stepperLabelColor")
        static let noMealDescText: String = "Description: This API does not have meal description"
        static let priceLabelAlpha: CGFloat = 0.0
    }
}

// MARK: - Action
extension HomeDetailViewController {
    @objc
    private func didItemCountChanged() {
        presenter?.calculatePrice(by: stepper.value)
    }
    
    @IBAction private func didAddToCartTapped(_ sender: UIButton) {
        presenter?.addMealsToCartInApi(orderCount: stepper.value)
    }
}
// MARK: - PresenterToView

extension HomeDetailViewController: HomeDetailPresenterOutputInterface {
    func configureMealImageView(with url: URL) {
        mealImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        mealImageView.sd_setImage(with: url)
    }
    func configureMealNameLabel(_ text: String) {
        mealNameLabel.text = text
    }
    
    func configurePriceLabel(_ text: String) {
        individualPriceLabel.text = text
        priceLabel.text = text
    }
    
    func configureDescriptionLabel(_ text: String) {
        mealDescriptionLabel.text = text
    }
    
    func configureStepperView() {
        stepper.value = HomeViewConstants.stepperValue
        stepper.minimumValue = HomeViewConstants.stepperMinimumValue
        stepper.maximumValue = HomeViewConstants.stepperMaximumValue
        stepper.stepValue = HomeViewConstants.stepperStepValue
        stepper.autorepeat = HomeViewConstants.stepperAutoRepeat
        stepper.leftButtonText = HomeViewConstants.stepperLeftButtonText
        stepper.rightButtonText = HomeViewConstants.stepperRightButtonText
        stepper.buttonsBackgroundColor = HomeViewConstants.stepperButtonsBackgroundColor
        stepper.labelTextColor = HomeViewConstants.stepperLabelTextColor
        stepper.labelBackgroundColor = HomeViewConstants.stepperLabelBackgroundColor
        stepper.labelFont = Constants.Font.tooGeneralFont
        stepper.cornerRadius = HomeViewConstants.stepperCornerRadius
        stepper.labelWidthWeight = HomeViewConstants.stepperLabelWidthWeight
        stepper.limitHitAnimationColor = HomeViewConstants.stepperAnimationColor
        stepper.addTarget(self, action: #selector(didItemCountChanged), for: .valueChanged)
    }
    func setBackgroundColor() {
        view.backgroundColor = HomeViewConstants.backgroundColor
    }
    func didPriceChanged(price: String) {
        DispatchQueue.main.async {
            self.priceLabel.alpha = HomeViewConstants.priceLabelAlpha
            self.priceLabel.text = price
            self.priceLabel.fadeIn(
                duration: HomeViewConstants.priceLabelFadeDuration,
                delay: HomeViewConstants.priceLabelFadeDelay
            ) { _ in
            }
        }
    }
}
