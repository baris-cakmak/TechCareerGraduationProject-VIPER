//
//  MainTabBarControler.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import UIKit
import CommonKit
import DependencyManagerKit
import RestaurantModuleInterface
import CartModuleInterface
import ProfileModuleInterface

protocol MainTabBarPresenterOutputInterface: AnyObject {
    func updateBadgeValueOfCartTabBar(_ value: String?)
    func configureTabBarAppeareance()
    func configureViewControllers()
}

final class MainTabBarController: UITabBarController {
    // MARK: - Presenter
    var presenter: MainTabBarPresenterInterface?
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
}

// MARK: - Helper
extension MainTabBarController {
    private func setRootViewControllers(navigations: [UINavigationController], modules: [UIViewController]) {
        navigations.enumerated().forEach { navigationController in
            navigationController.element.pushViewController(modules[navigationController.offset], animated: false)
        }
    }
    private func itemColorSwitch(itemApperance: UITabBarItemAppearance) {
        itemApperance.normal.iconColor = UIColor.label
        itemApperance.selected.iconColor = UIColor(named: "tabBarTint")
    }
    private func badgeItemSwitch(itemApperance: UITabBarItemAppearance) {
        itemApperance.normal.badgeTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.secondarySystemBackground]
        itemApperance.normal.badgeBackgroundColor = UIColor(named: "tabBarTint")
        itemApperance.selected.badgeBackgroundColor = .systemIndigo
    }
    
    private func templateNavigationController(
        unselectedImage: UIImage,
        selectedImage: UIImage
    ) -> UINavigationController {
        let navigationController: UINavigationController = .init()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        
        return navigationController
    }
}
// MARK: - Presenter To View

extension MainTabBarController: MainTabBarPresenterOutputInterface {
    func configureTabBarAppeareance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(named: "blurBackground")
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let uiTabBarAppearances = [appearance.stackedLayoutAppearance, appearance.compactInlineLayoutAppearance, appearance.inlineLayoutAppearance]
        uiTabBarAppearances.forEach { itemAppereance in
            itemColorSwitch(itemApperance: itemAppereance)
            badgeItemSwitch(itemApperance: itemAppereance)
        }
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBarItem.badgeColor = UIColor.systemIndigo
        tabBar.barStyle = .default
        tabBar.isTranslucent = true
        tabBar.selectionIndicatorImage = UIImage(named: "selected")
        tabBar.tintColor = UIColor(named: "tabBarTint")
        
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 30
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        additionalSafeAreaInsets.bottom = UIScreen.main.bounds.height < 800 ? 20 : 0
    }
        
    func configureViewControllers() {
        @Dependency var resturantModule: RestaurantModuleInterface
        @Dependency var cartModule: CartModuleInterface
        @Dependency var profileModule: ProfileModuleInterface
        
        let first = templateNavigationController(
            unselectedImage: UIImage.named("restaurantTabImage"),
            selectedImage: UIImage.named("restaurantTabImageSelected")
        )
        let second = templateNavigationController(
            unselectedImage: UIImage.named("shoppingCart"),
            selectedImage: UIImage.named("shoppingCartSelected")
        )
        let third = templateNavigationController(
            unselectedImage: UIImage.named("profile"),
            selectedImage: UIImage.named("profileSelected")
        )
        let navigationControllers: [UINavigationController] = [first, second, third]
        
        let modules = [
            resturantModule.createModule(using: first),
            cartModule.createModule(using: second),
            profileModule.createModule(using: third)
        ]
        setRootViewControllers(navigations: navigationControllers, modules: modules)
        
        viewControllers = navigationControllers
    }
    func updateBadgeValueOfCartTabBar(_ value: String?) {
        self.viewControllers?[Constants.TabBar.cartTabBarIndex].tabBarItem.badgeValue = value
    }
}
