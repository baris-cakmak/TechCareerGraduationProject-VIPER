//
//  YemeklerAPIManager.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation
import CommonKit
import Moya

public protocol MealsAPINetworkable {
//    var provider: MoyaProvider<MealsAPIEndPoint> { get }
    func getAllMeals(completion: @escaping (Result<MealResponseModel, Error>) -> Void)
    func getMealAtTheCart(username: String, completion: @escaping (Result<MealCartResponseModel, Error>) -> Void)
    func addMealToCart(addToCartRequestModel: MealAddToCartRequestModel, completion: @escaping (Result<MealSuccessResponseModel, Error>) -> Void)
    func deleteMealFromTheCart(mealDeleteRequestModel: MealDeleteRequestModel, completion: @escaping (Result<MealSuccessResponseModel, Error>) -> Void)
}

public final class MealsNetworkAPIManager: MealsAPINetworkable {
    private var provider: MoyaProvider<MealsAPIEndPoint> = MoyaProvider<MealsAPIEndPoint>(plugins: [NetworkLoggerPlugin.verbose])
    
    public init() {}
    
    public func getAllMeals(completion: @escaping (Result<MealResponseModel, Error>) -> Void) {
        request(target: .getAllMeals, completion: completion)
    }
    public func getMealAtTheCart(username: String, completion: @escaping (Result<MealCartResponseModel, Error>) -> Void) {
        request(target: .getCartResponse(username: username), completion: completion)
    }
    
    public func addMealToCart(addToCartRequestModel: MealAddToCartRequestModel, completion: @escaping (Result<MealSuccessResponseModel, Error>) -> Void) {
        request(
            target: .addMealsToCart(
                username: addToCartRequestModel.username,
                mealName: addToCartRequestModel.mealName,
                mealImageName: addToCartRequestModel.mealImageName,
                mealPrice: addToCartRequestModel.mealPrice,
                mealDeliveryCount: addToCartRequestModel.orderCount
            ),
            completion: completion
        )
    }
    
    public func deleteMealFromTheCart(mealDeleteRequestModel: MealDeleteRequestModel, completion: @escaping (Result<MealSuccessResponseModel, Error>) -> Void) {
        request(
            target: .deleteMealInCart(
                username: mealDeleteRequestModel.username,
                cartId: mealDeleteRequestModel.cartId
            ),
            completion: completion
        )
    }
}

extension MealsNetworkAPIManager {
    private func request<T: Decodable>(target: MealsAPIEndPoint, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
