//
//  Constants.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation
import FirebaseFirestore

let sceneDelegate = (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate)


class Constants {
    static let somethingWentWrongUrl: URL = URL(string: "https://i.pinimg.com/originals/b8/b8/f7/b8b8f787c454cf1ded2d9d870707ed96.png")!
    
    static let homeTabBarIndex: Int = 0
    static let cartTabBarIndex: Int = 1
    static let profileTabBarIndex: Int = 2
    static let usersCollection = Firestore.firestore().collection("users")
    static let apiImagesConstantUrlString = "http://kasimadalan.pe.hu/yemekler/resimler/"
}

