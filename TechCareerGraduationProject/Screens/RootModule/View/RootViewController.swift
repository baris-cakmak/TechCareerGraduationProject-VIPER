//
//  RootViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import UIKit

class RootViewController: UIViewController {
    
    
    // MARK: - Presenter
    var presenter: ViewToPresenterRootProtocol?
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        configureGlobalNavigationAppereance()
        presenter?.viewWillAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helper
    
    func configureGlobalNavigationAppereance() {
        let appearance = UINavigationBarAppearance()
        
        let backImage = UIImage(named: "back")!
        appearance.configureWithTransparentBackground()
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: UIImage(named: "back")!)
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        
        UINavigationBar.appearance().tintColor = .white
    }
    
    
}
