//
//  AppDelegate.swift
//  dummy
//
//  Created by Peace on 21.06.2022.
//

import UIKit
import FirebaseCore
import CommonKit
import DependencyManagerKit
import RootModuleInterface

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        WindowChanger.shared.window = window
        
        let dependencyContainer = DependencyContainer()
        dependencyContainer.injectDependencies()
        
        @Dependency var rootModule: RootModuleInterface
        let root = rootModule.createModule(using: nil)
                
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        return true
    }
}
// MARK: - Method
extension AppDelegate {
    func changeRootViewController(window: UIWindow?, _ vc: UIViewController, animated: Bool = true) {
        guard let window = window else {
            return
        }
        
        window.rootViewController = vc
        if animated {
            UIView.transition(
                with: window,
                duration: 0.5,
                options: [.transitionFlipFromBottom],
                animations: nil,
                completion: nil
            )
        }
    }
}
