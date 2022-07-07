//
//  MealAddBasketResponseModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation

public struct MealCartResponseModel: Decodable {
    public var mealCart: [MealCart]
    public var success: Int

    enum CodingKeys: String, CodingKey {
        case mealCart = "sepet_yemekler"
        case success
    }
}
