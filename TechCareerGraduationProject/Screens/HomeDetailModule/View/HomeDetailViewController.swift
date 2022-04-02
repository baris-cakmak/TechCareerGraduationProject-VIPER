//
//  HomeDetailViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 23.03.2022.
//

import UIKit
import GMStepper
import SDWebImage

class HomeDetailViewController: UIViewController {
        
    // MARK: - UI Properties
    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var stepper: GMStepper!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealDescriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mealPriceLabel: UILabel!
    
    // MARK: - Presenter
    
    var presenter: ViewToPresenterHomeDetailProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStepperView()
        print("debug: View Is Initialized")
        view.backgroundColor = .systemIndigo
        presenter?.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getItemsAtTheCart()
    }
    
    // MARK: - Helper
    
    func configureStepperView() {
        stepper.value = 1
        stepper.minimumValue = 1
        stepper.maximumValue = 100
        stepper.stepValue = 1
        stepper.autorepeat = true
        stepper.leftButtonText = "➖"
        stepper.rightButtonText = "➕"
        stepper.buttonsBackgroundColor = UIColor(named: "blurBackground")!
        stepper.labelTextColor = UIColor(named: "stepperLabelColor")!
        stepper.labelBackgroundColor = UIColor.clear
        stepper.labelFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        stepper.cornerRadius = 20
        stepper.labelWidthWeight = 0.4
        stepper.limitHitAnimationColor = UIColor(named: "stepperLabelColor")!
        stepper.addTarget(self, action: #selector(didItemCountChanged) , for: .valueChanged)
            
    }
    
    // MARK: - Action
    @objc
    func didItemCountChanged() {
        presenter?.calculatePrice(by: stepper.value)
    }
    
    @IBAction func didAddToCartTapped(_ sender: UIButton) {

        presenter?.addMealsToCartInApi(orderCount: stepper.value)
    }
    
}

// MARK: - PresenterToView

extension HomeDetailViewController: PresenterToViewHomeDetailProtocol {
    
    func updateBadgeValueOfCartTabBar(_ value: String?) {
        DispatchQueue.main.async {
            self.tabBarController?.viewControllers?[Constants.cartTabBarIndex].tabBarItem.badgeValue = value
        }
    }
    
    func configureInitialView(viewModel: MealViewModel) {
        DispatchQueue.main.async {
            self.mealNameLabel.text = viewModel.mealName
            self.mealImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
            self.mealImageView.sd_setImage(with: viewModel.mealImageUrl)
            self.mealDescriptionLabel.text = viewModel.mealDesc ?? "Description: This API does not have meal description"
            self.priceLabel.text = "₺ \(viewModel.mealPrice)"
            self.mealPriceLabel.text = "Price is ₺ \(viewModel.mealPrice)"
        }
    }
    
    func didPriceChanged(price: String) {
        DispatchQueue.main.async {
            self.priceLabel.alpha = 0
            self.priceLabel.text = price
            self.priceLabel.fadeIn(duration: 0.5, delay: 0) { (finished: Bool) -> Void in}
        }
    }
    
}
