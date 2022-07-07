//
//  DependencyContainer.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 25.06.2022.
//

import Foundation

import RootModule
import RootModuleInterface
import OnboardingModule
import OnboardingModuleInterface
import LoginModule
import LoginModuleInterface
import MainTabBarModule
import MainTabBarModuleInterface
import DependencyManagerKit
import UserStorageManagerKit
import OnboardingManagerKit
import SignInValidatorKit
import SignUpValidatorKit
import MealApiKit
import DummyRestaurantApiKit
import ImageUploaderKit
import UserManagerKit
import ProfileModule
import ProfileModuleInterface
import CartModule
import CartModuleInterface
import RestaurantModule
import RestaurantModuleInterface
import HomeModule
import HomeModuleInterface
import HomeDetailModule
import HomeDetailModuleInterface
import RegisterModule
import RegisterModuleInterface

final class DependencyContainer {
    func injectDependencies() {
        let dependencyEngine = DependencyEngine.shared
        dependencyEngine.register(value: RootRouter(), for: RootModuleInterface.self)
        dependencyEngine.register(value: OnboardingRouter(navigationController: nil), for: OnboardingModuleInterface.self)
        dependencyEngine.register(value: UserStorageManager.shared, for: UserStorageManagerable.self)
        dependencyEngine.register(value: OnboardingManager(), for: OnboardingManagerable.self)
        dependencyEngine.register(value: SignInValidator(signInModel: nil), for: SignInValidatorInterface.self)
        dependencyEngine.register(value: SignUpValidator(signUpModel: nil), for: SignUpValidatorInterface.self)
        dependencyEngine.register(value: MealsNetworkAPIManager(), for: MealsAPINetworkable.self)
        dependencyEngine.register(value: MyDummyRestaurantAPINetworkManager(), for: MyDummyRestaurantAPINetworkable.self)
        dependencyEngine.register(value: ImageUploader.shared, for: ImageUploadable.self)
        dependencyEngine.register(value: LoginRouter(navigationController: nil), for: LoginModuleInterface.self)
        dependencyEngine.register(value: UserManager(), for: UserManagerProvider.self)
        dependencyEngine.register(value: MainTabBarRouter(), for: MainTabBarModuleInterface.self)
        dependencyEngine.register(value: ProfileRouter(navigationController: nil), for: ProfileModuleInterface.self)
        dependencyEngine.register(value: CartRouter(navigationController: nil), for: CartModuleInterface.self)
        dependencyEngine.register(value: RestaurantRouter(navigationController: nil), for: RestaurantModuleInterface.self)
        dependencyEngine.register(value: HomeRouter(navigationController: nil), for: HomeModuleInterface.self)
        dependencyEngine.register(value: HomeDetailRouter(navigationController: nil), for: HomeDetailModuleInterface.self)
        dependencyEngine.register(value: RegisterRouter(navigationController: nil), for: RegisterModuleInterface.self)
    }
}
