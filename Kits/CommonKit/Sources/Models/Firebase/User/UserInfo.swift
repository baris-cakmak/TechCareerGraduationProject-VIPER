//
//  User.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import Foundation

public struct UserInfo {
    public let username: String
    public let email: String
    public let profileImageURL: String
    public let uid: String

    public init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageURL = dictionary["profileImageUrl"] as? String ?? Constants.MealApi.somethingWentWrongUrl
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
