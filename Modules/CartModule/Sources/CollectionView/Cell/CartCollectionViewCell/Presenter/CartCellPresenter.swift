//
//  CartCellPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 16.05.2022.
//

import Foundation
import CommonKit

// MARK: - Presenter Protocol
protocol CartCellPresenterInterface {
    func cellDidLoad()
    func didStepperValueChanged(for cell: CartCollectionViewCellInterface, _ value: Double)
    func deleteMeal(for cell: CartCollectionViewCellInterface)
}

// MARK: - Delegate Protocol
protocol CartCollectionViewCellDelegate: AnyObject {
    func updateFooterForNewTotalPrice(for cell: CartCollectionViewCellInterface, value: Double)
    func didUserDecidedToDeleteMeal(for cell: CartCollectionViewCellInterface, by cartId: Int)
}

final class CartCellPresenter: CartCellPresenterInterface {
    weak private var view: CartCollectionViewCellInterface?
    weak private var delegate: CartCollectionViewCellDelegate?
    private var cartViewModel: CartViewModel
    
    init (
        view: CartCollectionViewCellInterface,
        delegate: CartCollectionViewCellDelegate,
        cartViewModel: CartViewModel
    ) {
        self.view = view
        self.delegate = delegate
        self.cartViewModel = cartViewModel
    }
}
// MARK: - Helper
extension CartCellPresenter {
    private func setMealNameLabel() {
        view?.configureMealNameLabel(cartViewModel.mealName)
    }
    private func setStepperView() {
        view?.configureStepperView(currentValue: cartViewModel.stepperCurrentValue, leftButtonText: cartViewModel.stepperLeftButtonText)
    }
    private func setMealImageView() {
        if let imageUrl = cartViewModel.mealImageUrl {
            view?.configureMealImageView(with: imageUrl)
        } else {
            view?.configureMealImageView(with: .string(Constants.MealApi.somethingWentWrongUrl))
        }
    }
    private func setMealDescriptionLabel() {
        view?.configureMealDescriptionLabel(cartViewModel.mealDescription)
    }
    private func setPriceLabel() {
        view?.configurePriceLabel(cartViewModel.totalPrice)
    }
}

// MARK: - Method
extension CartCellPresenter {
    func cellDidLoad() {
        view?.configureCellAppearance()
        setPriceLabel()
        setStepperView()
        setMealImageView()
        setMealNameLabel()
        setMealDescriptionLabel()
    }
    func didStepperValueChanged(for cell: CartCollectionViewCellInterface, _ value: Double) {
        if value == .zero {
            delegate?.didUserDecidedToDeleteMeal(for: cell, by: cartViewModel.cartId)
            return
        }
        cartViewModel.stepperCurrentValue = value
        cartViewModel.totalPrice = calculateTotalPrice(count: value, pricePerItem: cartViewModel.mealPrice)
        cartViewModel.stepperLeftButtonText = handleStepperStatus(orderCount: value)
        view?.configurePriceLabel(cartViewModel.totalPrice)
        view?.configureStepperView(currentValue: value, leftButtonText: cartViewModel.stepperLeftButtonText)
        delegate?.updateFooterForNewTotalPrice(for: cell, value: cartViewModel.stepperCurrentValue)
    }
    func deleteMeal(for cell: CartCollectionViewCellInterface) {
        delegate?.didUserDecidedToDeleteMeal(for: cell, by: cartViewModel.cartId)
    }
}
// MARK: - Cart Item Changable
extension CartCellPresenter: CartItemChangable {
}
