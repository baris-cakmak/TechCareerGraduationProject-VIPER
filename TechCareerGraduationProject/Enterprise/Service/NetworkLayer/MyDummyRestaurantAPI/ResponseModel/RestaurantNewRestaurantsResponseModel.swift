//
//  RestaurantNewRestaurantsResponseModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import Foundation

struct RestaurantNewRestaurantsResponseModel: Decodable {
    let id: Int
    let restaurantName: String
    let category: RestaurantCategory
    let restaurantPoint: String
    let status: RestaurantStatus
    let restaurantImageUrl: String
}

enum RestaurantCategory: String, Decodable {
    case grill = "Grill"
    case kebap = "Kebap"
    case vegan = "Vegan"
    case fastFood = "FastFood"
}

enum RestaurantStatus: String, Decodable {
    case excellent
    case bad
    case good
}
extension RestaurantCategory: CaseIterable{}
extension RestaurantStatus: CaseIterable{}

