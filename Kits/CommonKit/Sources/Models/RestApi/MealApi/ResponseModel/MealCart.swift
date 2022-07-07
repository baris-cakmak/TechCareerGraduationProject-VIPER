//
//  SepetYemek.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation

public struct MealCart: Decodable {
    public let cartMealId: String
    public let cartMealName: String
    public let cartMealImageName: String
    public let cartMealPrice: String
    public let cartMealOrderCount: String
    public let username: String?

    enum CodingKeys: String, CodingKey {
        case cartMealId = "sepet_yemek_id"
        case cartMealName = "yemek_adi"
        case cartMealImageName = "yemek_resim_adi"
        case cartMealPrice = "yemek_fiyat"
        case cartMealOrderCount = "yemek_siparis_adet"
        case username = "kullanici_adi"
    }
}
