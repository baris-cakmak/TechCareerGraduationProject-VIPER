//
//  AuthCredentials.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import Foundation
import UIKit.UIImage

public struct AuthCredentials {
    public let email: String
    public let password: String
    public let username: String
    public let profileImage: UIImage
    
    public init(
        email: String,
        password: String,
        username: String,
        profileImage: UIImage
    ) {
        self.email = email
        self.password = password
        self.username = username
        self.profileImage = profileImage
    }
}
