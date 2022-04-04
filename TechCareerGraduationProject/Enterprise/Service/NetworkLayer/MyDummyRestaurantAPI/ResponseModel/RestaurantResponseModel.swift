//
//  RestaurantResponseModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import Foundation

struct RestaurantResponseModel: Decodable {
    let id: Int
    let restaurantName: String
    let restaurantPoint: String
    let adress: String
    let minimumPrice: String
    let deliveryCost: String
    let status: RestaurantStatus
    let restaurantImageUrl: String
}
