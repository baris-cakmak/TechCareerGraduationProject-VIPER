//
//  SepetYemek.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation

struct MealCart: Decodable {
    var cartMealId: String
    var cartMealName: String
    var cartMealImageName:String
    var cartMealPrice: String
    var cartMealOrderCount: String
    var username: String
    
    enum CodingKeys: String, CodingKey {
        case cartMealId = "sepet_yemek_id"
        case cartMealName = "yemek_adi"
        case cartMealImageName = "yemek_resim_adi"
        case cartMealPrice = "yemek_fiyat"
        case cartMealOrderCount = "yemek_siparis_adet"
        case username = "kullanici_adi"
    }
}
