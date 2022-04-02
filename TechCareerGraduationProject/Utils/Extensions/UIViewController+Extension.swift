//
//  UIViewController+Extension.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import UIKit


enum StoryboardName: String {
    case home = "Home"
    case homeDetail = "HomeDetail"
    case cart = "Cart"
    case login = "Login"
    case register = "Register"
    case profile = "Profile"
    case onboarding = "Onboard"

}

protocol Storyboardable {
    
    // MARK: - Properties
    
    static var storyboardBundle: Bundle { get }
    
    static var storyboardIdentifier: String { get }
    
    // MARK: - Methods
    
    static func instantiate(with storyboardName: StoryboardName) -> Self
    
}

extension Storyboardable where Self: UIViewController {
    
    // MARK: - Properties

    
    static var storyboardBundle: Bundle {
        return .main
    }
    
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Methods
    
    static func instantiate(with storyboardName: StoryboardName) -> Self {
        guard let viewController = UIStoryboard(name: storyboardName.rawValue, bundle: storyboardBundle).instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("debug: instantiating is failed due to \(storyboardIdentifier)")
        }
        
        return viewController
    }

}

extension UIViewController: Storyboardable {}
