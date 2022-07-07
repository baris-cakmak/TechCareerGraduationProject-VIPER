//
//  Meals.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation

public struct MealResponseModel: Decodable {
    public let meal: [Meal]
    public let success: Int

    enum CodingKeys: String, CodingKey {
        case meal = "yemekler"
        case success
    }
}
