//
//  CartViewModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 26.03.2022.
//

import Foundation

struct CartViewModel {
    var cartId: Int
    var mealName: String
    var mealPrice: Int
    var mealImageUrl: URL?
    var mealDescription: String
    var stepperCurrentValue: Double
    var totalPrice: String
    var stepperLeftButtonText: String
}
