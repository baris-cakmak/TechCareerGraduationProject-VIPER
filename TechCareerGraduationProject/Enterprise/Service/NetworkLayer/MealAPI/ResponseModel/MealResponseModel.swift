//
//  Meals.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation

struct MealResponseModel: Decodable {
    let meal: [Meal]
    let success: Int
    
    enum CodingKeys: String, CodingKey {
        case meal = "yemekler"
        case success
    }
}
