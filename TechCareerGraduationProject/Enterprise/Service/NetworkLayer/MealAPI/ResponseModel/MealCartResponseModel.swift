//
//  MealAddBasketResponseModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation

struct MealCartResponseModel: Decodable {
    var mealCart: [MealCart]
    var success: Int
    
    enum CodingKeys: String, CodingKey {
        case mealCart = "sepet_yemekler"
        case success
    }
}

