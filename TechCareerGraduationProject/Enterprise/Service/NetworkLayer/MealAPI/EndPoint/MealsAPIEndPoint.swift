//
//  MealsAPIEndPoint.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation
import Moya


enum MealsAPIEndPoint {
    case getAllMeals
    case getCartResponse(username: String)
    case deleteMealInCart(username: String, cartId: Int)
    case addMealsToCart(username: String,
                        mealName: String,
                        mealImageName: String,
                        mealPrice: Int,
                        mealDeliveryCount: Int)
}

extension MealsAPIEndPoint: TargetType {
    
    typealias HTTPHeader = [String: String]
    typealias Parameters = [String: Any]
    
    var baseURL: URL {
        guard let url = URL(string: "http://kasimadalan.pe.hu/yemekler") else {
            fatalError("What are you doing bro?")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getAllMeals:
            return "/tumYemekleriGetir.php"
        case .getCartResponse:
            return "/sepettekiYemekleriGetir.php"
        case .deleteMealInCart:
            return "/sepettenYemekSil.php"
        case .addMealsToCart:
            return "/sepeteYemekEkle.php"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllMeals:
            return .get
        case .getCartResponse,.deleteMealInCart,.addMealsToCart:
            return .post
        }
    }
    
    var task: Task {
        switch self {
            
        case .getAllMeals:
            return .requestPlain
            
        case .getCartResponse(username: let username):
            
            let parameters: Parameters = ["kullanici_adi": username]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .deleteMealInCart(username: let username,
                               cartId: let cartId):
            let parameters: Parameters =
            [
                "kullanici_adi": username,
                "sepet_yemek_id": cartId
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .addMealsToCart(username: let username,
                             mealName: let mealName,
                             mealImageName: let mealImageName,
                             mealPrice: let mealPrice,
                             mealDeliveryCount: let mealDeliveryCount):
            let parameters: Parameters =
            [
                "yemek_adi" : mealName,
                "yemek_resim_adi" : mealImageName,
                "yemek_fiyat" : mealPrice,
                "yemek_siparis_adet" : mealDeliveryCount,
                "kullanici_adi" : username
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        }
    }
    
    var headers: HTTPHeader? {
        return nil
    }
    
    
}
