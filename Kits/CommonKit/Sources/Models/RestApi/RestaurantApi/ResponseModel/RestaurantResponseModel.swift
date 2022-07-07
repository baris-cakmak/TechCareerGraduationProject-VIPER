//
//  RestaurantResponseModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import Foundation

public struct RestaurantResponseModel: Decodable, Equatable {
    public let id: Int?
    public let restaurantName: String?
    public let restaurantPoint: String?
    public let adress: String?
    public let minimumPrice: String?
    public let deliveryCost: String?
    public let status: RestaurantStatus?
    public let restaurantImageUrl: String?
}
