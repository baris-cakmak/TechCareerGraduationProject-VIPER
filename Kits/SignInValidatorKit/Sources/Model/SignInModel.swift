//
//  SignInModel.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 7.06.2022.
//

import Foundation

public struct SignInModel: Equatable {
    public let email: String
    public let password: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
