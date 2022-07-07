//
//  ResturantCellPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 19.05.2022.
//

import Foundation
import CommonKit

protocol RestaurantCellPresenterInterface {
    func loadCell()
}

final class RestaurantCellPresenter: RestaurantCellPresenterInterface {
    weak private var view: RestaurantCellInterface?
    private var restaurantViewModel: RestaurantViewModel
    
    init(
        view: RestaurantCellInterface,
        restaurantViewModel: RestaurantViewModel
    ) {
        self.view = view
        self.restaurantViewModel = restaurantViewModel
    }
}
// MARK: - Helper
extension RestaurantCellPresenter {
    private func setRestaurantImage() {
        if let imageUrl = restaurantViewModel.restaurantImageUrl {
            view?.configureRestaurantFoodImageView(with: imageUrl)
        } else {
            view?.configureRestaurantFoodImageView(with: .string(Constants.MealApi.somethingWentWrongUrl))
        }
    }
    private func setRestaurantBackgroundPointColor() {
        if let restaurantPointBackgroundColor = restaurantViewModel.restaurantPointBackgroundColor {
            view?.configurePointBackgroundView(restaurantPointBackgroundColor)
        } else {
            view?.configurePointBackgroundView(.brokenWhite)
        }
    }
    
    private func setRestaurantAdress() {
        guard let restaurantAdress = restaurantViewModel.restaurantAdress else {
            return
        }
        view?.configureAdressLabel(restaurantAdress)
    }
    
    private func setRestaurantPoint() {
        guard let restaurantPoint = restaurantViewModel.restaurantPoint else {
            return
        }
        view?.configureRestaurantPointLabel(restaurantPoint)
    }
    
    private func setRestaurantDeliveryCost() {
        guard let restaurantDeliveryCost = restaurantViewModel.restaurantDeliveryCost else {
            return
        }
        view?.configureDeliveryCostLabel(restaurantDeliveryCost)
    }
    
    private func setRestaurantMinimumCost() {
        guard let restaurantMinimumCost = restaurantViewModel.restaurantMinimumCost else {
            return
        }
        view?.configurePriceLabel(restaurantMinimumCost)
    }
    
    private func setRestaurantName() {
        guard let restaurantName = restaurantViewModel.restaurantName else {
            return
        }
        view?.configureRestaurantNameLabel(restaurantName)
    }
}
// MARK: - Method
extension RestaurantCellPresenter {
    func loadCell() {
        view?.configureCellAppeareance()
        setRestaurantImage()
        setRestaurantBackgroundPointColor()
        setRestaurantAdress()
        setRestaurantPoint()
        setRestaurantDeliveryCost()
        setRestaurantMinimumCost()
        setRestaurantName()
    }
}
// MARK: - RestaurantPointColorSettable
extension RestaurantCellPresenter: RestaurantPointColorSettable {
}
