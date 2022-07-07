//
//  RestaurantHeaderBuilder.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 11.05.2022.
//

import UIKit

enum RestaurantHeaderBuilder {
    static func createRestaurantHeaderModule(of restaurantHeaderView: RestaurantHeaderView) {
        restaurantHeaderView.presenter = RestaurantFooterViewModel(headerView: restaurantHeaderView)
    }
}
