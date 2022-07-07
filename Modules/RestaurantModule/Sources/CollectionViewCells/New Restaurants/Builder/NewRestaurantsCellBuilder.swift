//
//  NewRestaurantsCellBuilder.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 19.05.2022.
//

import Foundation

enum NewRestaurantsCellBuilder {
    static func createCell(_ cell: NewRestaurantsCollectionViewCell, newRestaurantViewModel: NewRestaurantViewModel) {
        cell.presenter = NewRestaurantCellPresenter(view: cell, newRestaurantViewModel: newRestaurantViewModel)
    }
}
