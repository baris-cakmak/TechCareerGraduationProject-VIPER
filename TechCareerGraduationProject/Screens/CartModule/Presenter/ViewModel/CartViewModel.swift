//
//  CartViewModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 26.03.2022.
//

import Foundation

struct CartViewModel {
    let cartId: Int
    var mealName: String
    let mealPrice: String
    var mealImageUrl: URL
    var stepperCurrentValue: Double
    var totalPrice: String
    var stepperLeftLabel: String? = "-"
}
