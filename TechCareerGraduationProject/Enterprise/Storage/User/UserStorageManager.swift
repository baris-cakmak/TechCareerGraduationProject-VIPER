//
//  UserStorageManager.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 2.04.2022.
//

import Foundation

enum UserStorageKey: String {
    case username
}

class UserStorageManager {
    
    static let shared = UserStorageManager()
    
    private init() {}
    func setUserEmailForMealAPI(username: String) {
        UserDefaults.standard.set(username, forKey: UserStorageKey.username.rawValue)
    }
    func getUserEmailForMealAPI() -> String {
        UserDefaults.standard.string(forKey: UserStorageKey.username.rawValue)!
    }
    
    
}
