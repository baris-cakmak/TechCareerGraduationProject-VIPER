//
//  Meal.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation

public struct Meal: Decodable, Equatable {
    public let mealId: String?
    public let mealName: String?
    public let mealImageUrlString: String?
    public let mealPrice: String?
    public let mealDesc: String?

    enum CodingKeys: String, CodingKey {
        case mealId = "yemek_id"
        case mealName = "yemek_adi"
        case mealImageUrlString = "yemek_resim_adi"
        case mealPrice = "yemek_fiyat"
        case mealDesc
    }
}
