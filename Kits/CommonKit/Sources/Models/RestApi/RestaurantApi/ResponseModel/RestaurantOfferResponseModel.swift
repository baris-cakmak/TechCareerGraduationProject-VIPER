//
//  RestaurantOfferResponseModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import Foundation

public struct RestaurantOfferResponseModel: Decodable, Equatable {
    public let id: Int?
    public let title: String?
    public let imageUrlString: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageUrlString = "imageUrl"
    }
}
