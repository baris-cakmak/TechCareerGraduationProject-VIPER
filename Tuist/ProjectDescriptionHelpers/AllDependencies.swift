//
//  AllDependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Peace on 19.06.2022.
//

import Foundation
import ProjectDescription

// MARK: - Path Constants
public enum PathConstants {
    public static let modulesPath: String = "Modules/"
    public static let kitsPath: String = "Kits/"
    public static let xcFrameWorksPath: String = "XCFrameworks/"
    public static let interfacesPath: String = "ModuleInterfaces/"
    public static let configPath: String = "config/"
}

// MARK: - XCFrameworkPaths
private enum XCFrameworkPaths: String {
    case gMStepper
    case moya
    case alamofire
    
    var description: String {
        rawValue.prefix(1).capitalized + rawValue.dropFirst()
    }
}

// MARK: - Module Paths
private enum ModulePaths: String {
    case homeModule
    case homeDetailModule
    case rootModule
    case onboardingModule
    case mainTabBarModule
    case loginModule
    case registerModule
    case restaurantModule
    case cartModule
    case profileModule
    
    var description: String {
        rawValue.prefix(1).capitalized + rawValue.dropFirst()
    }
    func createModuleTargetDependency() -> TargetDependency {
        .project(target: self.description, path: .relativeToRoot(PathConstants.modulesPath.appending(self.description)))
    }
}

// MARK: - Kit Paths
private enum KitPaths: String {
    case mealApiKit
    case userStorageManagerKit
    case onboardingManagerKit
    case userManagerKit
    case commonKit
    case imageUploaderKit
    case dependencyManagerKit
    case dummyRestaurantApiKit
    case signInValidatorKit
    case signUpValidatorKit
    case lottieAnimationConfigurableKit
    case baseKit

    var description: String {
        rawValue.prefix(1).capitalized + rawValue.dropFirst()
    }
    func makeTargetDependency() -> TargetDependency {
        .project(target: self.description, path: .relativeToRoot(PathConstants.kitsPath.appending(self.description)))
    }
}

// MARK: - Third Parties
public enum ExternalSwiftPackageManager: String {
    case lottie
    case sDWebImage
    case firebaseAnalytics
    case firebaseStorage
    case firebaseFirestore
    case firebaseAuth
    
    public var description: String {
        rawValue.prefix(1).capitalized + rawValue.dropFirst()
    }
    // wrap .external as targetdepenceny return type..
}
// MARK: - Interface Paths
public enum InterfacePaths: String {
    case homeModuleInterface
    case homeDetailModuleInterface
    case rootModuleInterface
    case onboardingModuleInterface
    case mainTabBarModuleInterface
    case loginModuleInterface
    case registerModuleInterface
    case restaurantModuleInterface
    case cartModuleInterface
    case profileModuleInterface
    
    public var description: String {
        rawValue.prefix(1).capitalized + rawValue.dropFirst()
    }
    func makeTarget() -> Target {
        .init(
            name: self.description,
            platform: .iOS,
            product: .staticFramework,
            bundleId: "bariscakmak.\(self.description)",
            infoPlist: .default,
            sources: ["InterfaceSources/**"]
        )
    }
    func createInterfaceTargetDependency() -> TargetDependency {
        .project(target: self.description, path: .relativeToRoot(PathConstants.modulesPath.appending(self.description).replacingOccurrences(of: "Interface", with: "")))
    }
}
// MARK: - All Dependencies
public enum AllDependencies {
    // MARK: - Module Interfaces
    public enum ModuleInterfaces {
        public static let homeModuleInterfaceTarget: Target = InterfacePaths.homeModuleInterface.makeTarget()
        public static let homeModuleInterfaceTargetDependency: TargetDependency = InterfacePaths.homeModuleInterface.createInterfaceTargetDependency()
        public static let homeDetailModuleInterfaceTarget: Target = InterfacePaths.homeDetailModuleInterface.makeTarget()
        public static let homeDetailModuleTargetDependency: TargetDependency = InterfacePaths.homeDetailModuleInterface.createInterfaceTargetDependency()
        public static let rootModuleInterfaceTarget: Target = InterfacePaths.rootModuleInterface.makeTarget()
        public static let rootModuleInterfaceTargetDependency: TargetDependency = InterfacePaths.rootModuleInterface.createInterfaceTargetDependency()
        public static let onboardingModuleInterfaceTarget: Target = InterfacePaths.onboardingModuleInterface.makeTarget()
        public static let onboardingModuleInterfaceTargetDependency: TargetDependency = InterfacePaths.onboardingModuleInterface.createInterfaceTargetDependency()
        public static let mainTabBarModuleInterfaceTarget: Target = InterfacePaths.mainTabBarModuleInterface.makeTarget()
        public static let mainTabBarModuleInterfaceTargetDependency: TargetDependency = InterfacePaths.mainTabBarModuleInterface.createInterfaceTargetDependency()
        public static let loginModuleInterfaceTarget: Target = InterfacePaths.loginModuleInterface.makeTarget()
        public static let loginModuleInterfaceTargetDependency: TargetDependency = InterfacePaths.loginModuleInterface.createInterfaceTargetDependency()
        public static let registerModuleInterfaceTarget: Target = InterfacePaths.registerModuleInterface.makeTarget()
        public static let registerModuleInterfaceTargetDependency: TargetDependency = InterfacePaths.registerModuleInterface.createInterfaceTargetDependency()
        public static let restaurantModuleInterfaceTarget: Target = InterfacePaths.restaurantModuleInterface.makeTarget()
        public static let restaurantModuleInterfaceTargetDependency: TargetDependency = InterfacePaths.restaurantModuleInterface.createInterfaceTargetDependency()
        public static let cartModuleInterfaceTarget: Target = InterfacePaths.cartModuleInterface.makeTarget()
        public static let cartModuleInterfaceTargetDependency: TargetDependency = InterfacePaths.cartModuleInterface.createInterfaceTargetDependency()
        public static let profileModuleInterfaceTarget: Target = InterfacePaths.profileModuleInterface.makeTarget()
        public static let profileModuleInterfaceTargetDependency: TargetDependency = InterfacePaths.profileModuleInterface.createInterfaceTargetDependency()
    }
    // MARK: - XCFrameworks
    public enum XCFrameworks {
        public static let gmStepper: TargetDependency = .xcframework(path: .relativeToRoot(PathConstants.xcFrameWorksPath.appending("/GMStepper.xcframework")))
        public static let moya: TargetDependency = 
            .xcframework(path: .relativeToRoot(PathConstants.xcFrameWorksPath.appending("/Moya.xcframework")))
        public static let alamofire: TargetDependency = .xcframework(path: .relativeToRoot(PathConstants.xcFrameWorksPath.appending("/Alamofire.xcframework")))
    }
    // MARK: - Kits
    public enum Kits {
        public static let commonKit: TargetDependency = KitPaths.commonKit.makeTargetDependency()
        public static let userStorageManager: TargetDependency = KitPaths.userStorageManagerKit.makeTargetDependency()
        public static let onboardingManager: TargetDependency = KitPaths.onboardingManagerKit.makeTargetDependency()
        public static let mealsAPI: TargetDependency = KitPaths.mealApiKit.makeTargetDependency()
        public static let userManager: TargetDependency = KitPaths.userManagerKit.makeTargetDependency()
        public static let imageUploaderKit: TargetDependency = KitPaths.imageUploaderKit.makeTargetDependency()
        public static let dependencyManagerKit: TargetDependency = KitPaths.dependencyManagerKit.makeTargetDependency()
        public static let dummyRestaurantApiKit: TargetDependency = KitPaths.dummyRestaurantApiKit.makeTargetDependency()
        public static let signInValidatorKit: TargetDependency = KitPaths.signInValidatorKit.makeTargetDependency()
        public static let signUpValidatorKit: TargetDependency = KitPaths.signUpValidatorKit.makeTargetDependency()
        public static let lottieAnimationConfigurableKit: TargetDependency = KitPaths.lottieAnimationConfigurableKit.makeTargetDependency()
        public static let baseKit: TargetDependency = KitPaths.baseKit.makeTargetDependency()
    }
    // MARK: - Modules
    public enum Modules {
        public static let homeModule: TargetDependency = ModulePaths.homeModule.createModuleTargetDependency()
        public static let homeDetailModule: TargetDependency = ModulePaths.homeDetailModule.createModuleTargetDependency()
        public static let rootModule: TargetDependency = ModulePaths.rootModule.createModuleTargetDependency()
        public static let mainTabBarModule: TargetDependency = ModulePaths.mainTabBarModule.createModuleTargetDependency()
        public static let onboardingModule: TargetDependency = ModulePaths.onboardingModule.createModuleTargetDependency()
        public static let loginModule: TargetDependency = ModulePaths.loginModule.createModuleTargetDependency()
        public static let registerModule: TargetDependency = ModulePaths.registerModule.createModuleTargetDependency()
        public static let restaurantModule: TargetDependency = ModulePaths.restaurantModule.createModuleTargetDependency()
        public static let cartModule: TargetDependency = ModulePaths.cartModule.createModuleTargetDependency()
        public static let profileModule: TargetDependency = ModulePaths.profileModule.createModuleTargetDependency()
    }
}
