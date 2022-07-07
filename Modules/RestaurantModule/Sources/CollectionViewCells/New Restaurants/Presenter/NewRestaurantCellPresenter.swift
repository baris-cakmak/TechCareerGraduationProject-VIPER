//
//  NewRestaurantCellPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 19.05.2022.
//

import Foundation
import CommonKit

protocol NewRestaurantCellPresenterInterface {
    func loadCell()
}

final class NewRestaurantCellPresenter: NewRestaurantCellPresenterInterface {
    weak private var view: NewRestaurantCellInterface?
    private var newRestaurantViewModel: NewRestaurantViewModel

    init(
        view: NewRestaurantCellInterface,
        newRestaurantViewModel: NewRestaurantViewModel
    ) {
        self.view = view
        self.newRestaurantViewModel = newRestaurantViewModel
    }
}
// MARK: - Helper
extension NewRestaurantCellPresenter {
    private func setNewRestaurantImageUrl() {
        if let imageUrl = newRestaurantViewModel.restaurantImageUrl {
            view?.configureRestaurantImageView(imageUrl)
        } else {
            view?.configureRestaurantImageView(.string(Constants.MealApi.somethingWentWrongUrl))
        }
    }
    private func setRestaurantPointBackgroundColor() {
        if let backgroundColor = newRestaurantViewModel.restaurantPointBackgroundColor {
            view?.configureRestaurantPointBackgroundColor(backgroundColor)
        } else {
            view?.configureRestaurantPointBackgroundColor(.brokenWhite)
        }
    }
    
    private func setRestaurantPoint() {
        guard let restaurantPoint = newRestaurantViewModel.restaurantPoint else {
            return
        }
        view?.configurePointLabel(restaurantPoint)
    }
    private func setRestaurantName() {
        guard let restaurantName = newRestaurantViewModel.restaurantName else {
            return
        }
        view?.configureRestaurantNameLabel(restaurantName)
    }
    private func setCategoryTitle() {
        guard let categoryTitle = newRestaurantViewModel.categoryTitle else {
            return
        }
        view?.configureCategoryLabel(categoryTitle)
    }
}

// MARK: - Method
extension NewRestaurantCellPresenter {
    func loadCell() {
        view?.configureCellAppeareance()
        setNewRestaurantImageUrl()
        setRestaurantPointBackgroundColor()
        setRestaurantPoint()
        setRestaurantName()
        setCategoryTitle()
    }
}
