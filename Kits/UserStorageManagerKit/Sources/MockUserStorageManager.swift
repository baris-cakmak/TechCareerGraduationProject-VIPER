//
//  MockUserStorageManager.swift
//  TechCareerGraduationProjectTests
//
//  Created by Peace on 14.06.2022.
//

import Foundation

final class MockUserStorage: UserStorageManagerable {
    var invokedSetUserEmailForMealAPI = false
    var invokedSetUserEmailForMealAPICount = 0
    var invokedSetUserEmailForMealAPIParameters: (username: String, Void)?
    var invokedSetUserEmailForMealAPIParametersList = [(username: String, Void)]()

    func setUserEmailForMealAPI(username: String) {
        invokedSetUserEmailForMealAPI = true
        invokedSetUserEmailForMealAPICount += 1
        invokedSetUserEmailForMealAPIParameters = (username, ())
        invokedSetUserEmailForMealAPIParametersList.append((username, ()))
    }

    var invokedGetUserEmailForMealAPI = false
    var invokedGetUserEmailForMealAPICount = 0
    var stubbedGetUserEmailForMealAPIResult: String! = ""

    func getUserEmailForMealAPI() -> String {
        invokedGetUserEmailForMealAPI = true
        invokedGetUserEmailForMealAPICount += 1
        return stubbedGetUserEmailForMealAPIResult
    }
}
