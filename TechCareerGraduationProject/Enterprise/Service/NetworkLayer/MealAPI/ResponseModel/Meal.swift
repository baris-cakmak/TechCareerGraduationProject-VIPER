//
//  Meal.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation

struct Meal: Decodable {
    let mealId: String
    let mealName: String
    let mealImageUrl: String
    let mealPrice: String
    
    enum CodingKeys: String, CodingKey {
        case mealId = "yemek_id"
        case mealName = "yemek_adi"
        case mealImageUrl = "yemek_resim_adi"
        case mealPrice = "yemek_fiyat"
        
        
    }
}
