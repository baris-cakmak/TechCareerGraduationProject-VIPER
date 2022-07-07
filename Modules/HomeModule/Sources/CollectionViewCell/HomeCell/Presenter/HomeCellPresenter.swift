//
//  HomeCellPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 21.05.2022.
//

import Foundation
import CommonKit

protocol HomeCellPresenterInterface {
    func loadCell()
}

final class HomeCellPresenter: HomeCellPresenterInterface {
    weak private var view: HomeCellInterface?
    private var mealViewModel: MealViewModel
    
    init(view: HomeCellInterface, mealViewModel: MealViewModel) {
        self.view = view
        self.mealViewModel = mealViewModel
    }
}
// MARK: - Method
extension HomeCellPresenter {
    func loadCell() {
        view?.configureCellAppearance()
        if let priceLabelText = mealViewModel.mealPrice {
            view?.configurePriceLabel("₺ \(priceLabelText)")
        }
        if let mealNameText = mealViewModel.mealName {
            view?.configureMealNameLabel(mealNameText)
        }
        if let mealImageUrl = mealViewModel.mealImageUrl {
            view?.configureMealImageView(with: mealImageUrl)
        } else {
            view?.configureMealImageView(with: .string(Constants.MealApi.somethingWentWrongUrl))
        }
    }
}
