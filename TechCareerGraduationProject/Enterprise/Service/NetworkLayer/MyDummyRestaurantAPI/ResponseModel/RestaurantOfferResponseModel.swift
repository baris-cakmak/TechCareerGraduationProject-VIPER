//
//  RestaurantOfferResponseModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import Foundation

struct RestaurantOfferResponseModel: Decodable {
    let id: Int
    let title: String
    let imageUrl: String
}
