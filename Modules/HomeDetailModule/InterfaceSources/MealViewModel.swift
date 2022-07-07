//
//  MealViewModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation

public struct MealViewModel {
    public var mealName: String?
    public var mealImageUrl: URL?
    public var mealPrice: String?
    public var mealDesc: String?
    
    public init(mealName: String? = nil, mealImageUrl: URL? = nil, mealPrice: String? = nil, mealDesc: String? = nil) {
        self.mealName = mealName
        self.mealImageUrl = mealImageUrl
        self.mealPrice = mealPrice
        self.mealDesc = mealDesc
    }
}
