//
//  MainTabBarControler.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Presenter
    var presenter: ViewToPresenterMainTabBarProtocol?
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarAppeareance()
        configureViewControllers()
    }
    
    // MARK: - Handler
    
    func configureTabBarAppeareance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(named: "blurBackground")
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let uiTabBarAppearances = [appearance.stackedLayoutAppearance,appearance.compactInlineLayoutAppearance,appearance.inlineLayoutAppearance]
        uiTabBarAppearances.forEach { itemAppereance in
            itemColorSwitch(itemApperance: itemAppereance)
            badgeItemSwitch(itemApperance: itemAppereance)
        }
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        self.tabBarItem.badgeColor = UIColor.systemIndigo
        self.tabBar.barStyle = .default
        self.tabBar.isTranslucent = true
        self.tabBar.selectionIndicatorImage = UIImage(named: "selected")
        self.tabBar.tintColor = UIColor(named: "tabBarTint")

        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.cornerRadius = 30
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.additionalSafeAreaInsets.bottom = UIScreen.main.bounds.height < 800 ? 20 : 0

    }
    
    func configureViewControllers() {
        let restaurantNav = RestaurantRouter.createModule()
        let first = templateNavigationController(title: "Restaurants" ,unselectedImage: UIImage(named: "restaurantTabImage")!, selectedImage: UIImage(named: "restaurantTabImageSelected")!, navigationController: restaurantNav)
        let cartNav = CartRouter.createModule()
        let second = templateNavigationController(title: "Cart", unselectedImage: UIImage(named: "shoppingCart")!, selectedImage: UIImage(named: "shoppingCartSelected")!, navigationController: cartNav)
        let profileNav = ProfileRouter.createModule()
        let third = templateNavigationController(title: "Profile", unselectedImage: UIImage(named: "profile")!, selectedImage: UIImage(named: "profileSelected")!, navigationController: profileNav)
        viewControllers = [first, second, third]
    }
    

    // MARK: - Helper
    
    func itemColorSwitch(itemApperance: UITabBarItemAppearance) {
        
        itemApperance.normal.iconColor = UIColor.label
        itemApperance.selected.iconColor = UIColor(named: "tabBarTint")!

    }
    func badgeItemSwitch(itemApperance: UITabBarItemAppearance) {
        itemApperance.normal.badgeTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.secondarySystemBackground]
        itemApperance.normal.badgeBackgroundColor = UIColor(named: "tabBarTint")!
        itemApperance.selected.badgeBackgroundColor = .systemIndigo
    }
    

    
    func templateNavigationController(title: String,
                                      unselectedImage: UIImage,
                                      selectedImage: UIImage,
                                      navigationController: UINavigationController) -> UINavigationController {

        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.topItem?.title = title
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        return navigationController
    }
    
    
}

// MARK: - Presenter To View

extension MainTabBarController: PresenterToViewMainTabBarProtocol {
    
    func updateBadgeValueOfCartTabBar(_ value: String?) {
        DispatchQueue.main.async {
            self.viewControllers?[Constants.cartTabBarIndex].tabBarItem.badgeValue = value
        }

    }
}
