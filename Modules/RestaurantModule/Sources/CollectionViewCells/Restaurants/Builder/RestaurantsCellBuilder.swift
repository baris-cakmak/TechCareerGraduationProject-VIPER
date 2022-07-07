//
//  RestaurantsCellBuilder.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 19.05.2022.
//

import Foundation

enum RestaurantsCellBuilder {
    static func createCell(_ cell: RestaurantCollectionViewCell, restaurantViewModel: RestaurantViewModel) {
        cell.presenter = RestaurantCellPresenter(view: cell, restaurantViewModel: restaurantViewModel)
    }
}
