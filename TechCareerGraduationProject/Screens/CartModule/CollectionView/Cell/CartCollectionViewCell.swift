//
//  CartCollectionViewCell.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 25.03.2022.
//

import UIKit
import GMStepper
import SDWebImage


protocol CartCollectionViewCellDelegate: AnyObject {
    func didStepperValueChanged(_ stepper: GMStepper, stepperValue: Double, for cell: CartCollectionViewCell)
    
    func didTapDeleteButton(for cell: CartCollectionViewCell)
}


class CartCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - UI Properties
    
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stepperView: GMStepper!
    @IBOutlet weak var mealImageVİew: UIImageView!
    @IBOutlet weak var mealDescriptionLabel: UILabel!
    
    // MARK: - Delegate
    
    weak var delegate: CartCollectionViewCellDelegate?
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 30
        configureStepperView()
    }
    
    
    // MARK: - Handler
    func configureCell(with viewModel: CartViewModel) {
        mealName.text = viewModel.mealName
        stepperView.value = viewModel.stepperCurrentValue
        mealImageVİew.sd_setImage(with: viewModel.mealImageUrl)
        mealDescriptionLabel.text = "Price Per Item is \(viewModel.mealPrice)"
        priceLabel.text = "₺ \(viewModel.totalPrice)"
        stepperView.leftButtonText = viewModel.stepperLeftLabel!
    }
    

    func configureStepperView() {
        stepperView.value = 1
        stepperView.minimumValue = 0
        stepperView.maximumValue = 100
        stepperView.stepValue = 1
        stepperView.autorepeat = true
        stepperView.leftButtonText = "-"
        stepperView.rightButtonText = "+"
        stepperView.buttonsTextColor = UIColor.secondaryLabel
        stepperView.buttonsBackgroundColor = UIColor(named: "blurBackground")!
        stepperView.labelTextColor = UIColor(named: "stepperLabelColor")!
        stepperView.labelBackgroundColor = UIColor.clear
        stepperView.labelFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        stepperView.cornerRadius = 5
        stepperView.labelWidthWeight = 0.4
        stepperView.limitHitAnimationColor = UIColor(named: "stepperLabelColor")!
        stepperView.addTarget(self, action: #selector(didTapStepperButtons), for: .valueChanged)
    }

    // MARK: - Action
    
    @objc
    func didTapStepperButtons() {
        delegate?.didStepperValueChanged(stepperView, stepperValue: stepperView.value, for: self)
    }
    @IBAction func didTapDeleteButtton(_ sender: UIButton) {
        delegate?.didTapDeleteButton(for: self)
        
    }
}
