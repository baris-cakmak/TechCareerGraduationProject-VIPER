//
//  Constants.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import UIKit

public enum Constants {
    public enum Layout {
        public static let scale = UIScreen.main.scale
        public static let tooGeneralInsetConstant: CGFloat = 20.0
        public static let halfFraction: CGFloat = 0.5
        public static let fullFraction: CGFloat = 1.0
    }
    public enum TabBar {
        public static let homeTabBarIndex: Int = 0
        public static let cartTabBarIndex: Int = 1
        public static let profileTabBarIndex: Int = 2
    }
    public enum MealApi {
        public static let somethingWentWrongUrl = "https://i.pinimg.com/originals/b8/b8/f7/b8b8f787c454cf1ded2d9d870707ed96.png"
        public static let apiImagesConstantUrlString = "http://kasimadalan.pe.hu/yemekler/resimler/"
    }
    public enum Image {
        public static let placeholderImage: UIImage = .named("placeholderImage")
    }
    public enum System {
//        static let sceneDelegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
    }
    public enum Font {
        public static let tooGeneralFont: UIFont = .systemFont(ofSize: 20, weight: .bold)
    }
    public enum NavigationItem {
        public static let homeTitle = "Home"
        public static let cartTitle = "Cart"
        public static let restaurantTitle = "Restaurant"
        public static let profileTitle = "Profile"
    }
}
