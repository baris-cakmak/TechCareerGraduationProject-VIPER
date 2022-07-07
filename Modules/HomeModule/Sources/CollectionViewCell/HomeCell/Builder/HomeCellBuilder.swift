//
//  HomeCellBuilder.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 21.05.2022.
//

import Foundation

enum HomeCellBuilder {
    static func createCell(_ cell: HomeCollectionViewCell, mealViewModel: MealViewModel) {
        cell.presenter = HomeCellPresenter(view: cell, mealViewModel: mealViewModel)
    }
}
