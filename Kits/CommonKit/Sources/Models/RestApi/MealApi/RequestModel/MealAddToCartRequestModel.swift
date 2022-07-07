//
//  MealAddToCartRequestModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 24.03.2022.
//

import Foundation

public struct MealAddToCartRequestModel {
    public let username: String
    public let orderCount: Int
    public let mealPrice: Int
    public let mealImageName: String
    public let mealName: String
    
    public init(
        username: String,
        orderCount: Int,
        mealPrice: Int,
        mealImageName: String,
        mealName: String
    ) {
        self.username = username
        self.orderCount = orderCount
        self.mealPrice = mealPrice
        self.mealImageName = mealImageName
        self.mealName = mealName
    }
}
