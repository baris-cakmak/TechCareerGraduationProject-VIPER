//
//  RootVC.swift
//  RootModule
//
//  Created by Peace on 21.06.2022.
//

import UIKit

protocol RootPresenterOutputInterface: AnyObject {
    func configureGlobalNavigationAppereance()
}
final class RootViewController: UIViewController {
    // MARK: - Presenter
    var presenter: RootPresenterInterface?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
}
// MARK: - Presenter Output
extension RootViewController: RootPresenterOutputInterface {
    func configureGlobalNavigationAppereance() {
        let appearance = UINavigationBarAppearance()
        let backImage = UIImage(named: "back")
        appearance.configureWithTransparentBackground()
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: UIImage(named: "back"))
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
}
