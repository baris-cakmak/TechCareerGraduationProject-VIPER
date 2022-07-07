//
//  RestaurantNewRestaurantsResponseModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import Foundation

public struct RestaurantNewRestaurantsResponseModel: Decodable, Equatable {
    public let id: Int?
    public let restaurantName: String?
    public let category: RestaurantCategory?
    public let restaurantPoint: String?
    public let status: RestaurantStatus?
    public let restaurantImageUrlString: String?

    enum CodingKeys: String, CodingKey {
        case id, restaurantName, category, restaurantPoint, status
        case restaurantImageUrlString = "restaurantImageUrl"
    }
}

public enum RestaurantCategory: String, Decodable {
    case grill = "Grill"
    case kebap = "Kebap"
    case vegan = "Vegan"
    case fastFood = "FastFood"
}

public enum RestaurantStatus: String, Decodable {
    case excellent
    case bad
    case good
}
extension RestaurantCategory: CaseIterable {
}
extension RestaurantStatus: CaseIterable {
}
