//
//  HomeViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import UIKit
import Lottie
import CommonKit
import LottieAnimationConfigurableKit

typealias HomeViewInterface = NavigationItemUpdatable & LottieAnimationConfigurable

protocol HomePresenterOutputInterface: AnyObject, HomeViewInterface {
    func configureMealCollectionView()
    func reloadData()
    func updateBadgeCountOfCartTabBar(badgeValue: String?)
}

final class HomeViewController: UIViewController {
    // MARK: - UI Properties
    
    @IBOutlet weak private var mealCollectionView: UICollectionView!
    
    private(set) var animationView: AnimationView? = {
        let aV = AnimationView(animation: Animation.named(HomeViewConstants.animationName))
        aV.animationSpeed = HomeViewConstants.animationSpeed
        aV.backgroundColor = HomeViewConstants.animationBackgroundColor
        aV.loopMode = .loop
        return aV
    }()
    
    // MARK: - Presenter
    
    var presenter: HomePresenterInterface?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
}
// MARK: - Constant
extension HomeViewController {
    private enum HomeViewConstants {
        static let groupHeight: CGFloat = 255.0
        static let animationSpeed: CGFloat = 2.0
        static let animationBackgroundColor: UIColor = .named("blurBackground2").withAlphaComponent(0.7)
        static let animationName: String = Animations.foodLoading.rawValue
    }
}
// MARK: - Helper
extension HomeViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(Constants.Layout.halfFraction),
                    heightDimension: .fractionalHeight(Constants.Layout.fullFraction)
                )
            )
            item.contentInsets.trailing = Constants.Layout.tooGeneralInsetConstant
            item.contentInsets.bottom = Constants.Layout.tooGeneralInsetConstant
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(Constants.Layout.fullFraction),
                    heightDimension: .absolute(HomeViewConstants.groupHeight)
                ),
                subitems: [item]
            )
            group.contentInsets.leading = Constants.Layout.tooGeneralInsetConstant
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            return section
        }
    }
}

// MARK: - Presenter To View
extension HomeViewController: HomePresenterOutputInterface {
    func configureMealCollectionView() {
        mealCollectionView.dataSource = self
        mealCollectionView.delegate = self
        mealCollectionView.registerWithNib(HomeCollectionViewCell.self, bundle: .module)
        mealCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    func reloadData() {
        DispatchQueue.main.async {
            self.mealCollectionView.reloadData()
        }
    }
    func updateBadgeCountOfCartTabBar(badgeValue: String?) {
        tabBarController?.viewControllers?[Constants.TabBar.cartTabBarIndex].tabBarItem.badgeValue = badgeValue
    }
}
// MARK: - MealCollectionView DataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection() ?? .zero
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as HomeCollectionViewCell
        if let presenter = presenter {
            let mealViewModel = presenter.getHomeViewModel(at: indexPath)
            HomeCellBuilder.createCell(cell, mealViewModel: mealViewModel)
        }
        return cell
    }
}

// MARK: - MealCollectionView Delegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.goToHomeDetail(with: indexPath)
    }
}
