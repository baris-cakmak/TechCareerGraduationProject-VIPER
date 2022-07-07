//
//  SignUpModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 24.05.2022.
//

import Foundation

public struct SignUpModel {
    public let email: String
    public let passwordOne: String
    public let passwordTwo: String
    public let username: String
    
    public init(email: String, passwordOne: String, passwordTwo: String, username: String) {
        self.email = email
        self.passwordOne = passwordOne
        self.passwordTwo = passwordTwo
        self.username = username
    }
}
