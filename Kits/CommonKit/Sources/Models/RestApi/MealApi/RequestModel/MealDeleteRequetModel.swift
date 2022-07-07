//
//  MealDeleteRequetModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 27.03.2022.
//

import Foundation

public struct MealDeleteRequestModel {
    public let username: String
    public let cartId: Int
    
    public init(username: String, cartId: Int) {
        self.username = username
        self.cartId = cartId
    }
}
