//
//  RestaurantViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import UIKit
import CommonKit
import LottieAnimationConfigurableKit
import Lottie

typealias RestaurantViewInterface = NavigationItemUpdatable & LottieAnimationConfigurable

protocol RestaurantPresenterOutputInterface: AnyObject, RestaurantViewInterface {
    func configureRestaurantCollectionView()
    func reloadData()
}

final class RestaurantViewController: UIViewController {
    // MARK: - Preesenter
    
    var presenter: RestaurantPresenterInterface?
    
    // MARK: - UI Properties
    
    @IBOutlet weak private var restaurantCollectionView: UICollectionView!
    
    private(set) var animationView: AnimationView? = {
        let animation = Animation.named(RestaurantConstants.animationName)
        let aV = AnimationView(animation: animation)
        aV.loopMode = .loop
        aV.animationSpeed = RestaurantConstants.animationSpeed
        aV.backgroundColor = RestaurantConstants.animationBackgroundColor
        return aV
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRestaurantCollectionView()
        presenter?.viewDidLoad()
    }
}
// MARK: - Constant
extension RestaurantViewController {
    private enum RestaurantConstants {
        static let animationSpeed: CGFloat = 3.0
        static let animationBackgroundColor: UIColor = .named("blurBackground").withAlphaComponent(0.75)
        static let animationName: String = Animations.userLoading.rawValue
        static let offersGroupWidthFraction: CGFloat = 0.85
        static let offersGroupHeightSize: CGFloat = 230
        static let newRestaurantGroupHeightSize: CGFloat = 260
        static let headerItemHeightSize: CGFloat = 40
        static let restaurantHeightSize: CGFloat = 270
        static let offerMinScale: CGFloat = 0.8
        static let offerMaxScale: CGFloat = 1.05
        static let newRestaurantsMinScale: CGFloat = 0.87
        static let newRestaurantsMaxScale: CGFloat = 1.1
    }
}
// MARK: - Helper
extension RestaurantViewController {
    private func makeOfferSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(Constants.Layout.fullFraction),
                heightDimension: .fractionalHeight(Constants.Layout.fullFraction)
            )
        )
        item.contentInsets.bottom = Constants.Layout.tooGeneralInsetConstant
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(RestaurantConstants.offersGroupWidthFraction),
                heightDimension: .absolute(RestaurantConstants.offersGroupHeightSize)
            ), subitems: [item]
        )
        group.contentInsets.leading = Constants.Layout.tooGeneralInsetConstant
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.visibleItemsInvalidationHandler = { items, offset, environment in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = RestaurantConstants.offerMinScale
                let maxScale: CGFloat = RestaurantConstants.offerMaxScale
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        return section
    }
    
    private func makeNewRestaurantSection() -> NSCollectionLayoutSection {
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
                heightDimension: .absolute(RestaurantConstants.newRestaurantGroupHeightSize)
            ), subitems: [item]
        )
        group.contentInsets.leading = Constants.Layout.tooGeneralInsetConstant
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = Constants.Layout.tooGeneralInsetConstant
        section.orthogonalScrollingBehavior = .none
        section.visibleItemsInvalidationHandler = { items, offset, environment in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midY - offset.y) - environment.container.contentSize.height / 2.0)
                let minScale: CGFloat = RestaurantConstants.newRestaurantsMinScale
                let maxScale: CGFloat = RestaurantConstants.newRestaurantsMaxScale
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.height), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        let headerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.Layout.fullFraction),
            heightDimension: .absolute(RestaurantConstants.headerItemHeightSize)
        )
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerItemSize,
            elementKind: RestaurantKind.basicHeader.rawValue,
            alignment: .topLeading
        )
        headerItem.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [
            headerItem
        ]
        return section
    }
    
    private func makeRestaurantSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(Constants.Layout.fullFraction),
                heightDimension: .fractionalHeight(Constants.Layout.fullFraction)
            )
        )
        item.contentInsets.trailing = Constants.Layout.tooGeneralInsetConstant
        item.contentInsets.bottom = Constants.Layout.tooGeneralInsetConstant
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(Constants.Layout.fullFraction),
                heightDimension: .absolute(RestaurantConstants.restaurantHeightSize)
            ), subitems: [item]
        )
        group.contentInsets.leading = Constants.Layout.tooGeneralInsetConstant
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = Constants.Layout.tooGeneralInsetConstant
        section.orthogonalScrollingBehavior = .none
        
        let headerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.Layout.fullFraction),
            heightDimension: .absolute(RestaurantConstants.headerItemHeightSize)
        )
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerItemSize,
            elementKind: RestaurantKind.basicHeader.rawValue,
            alignment: .topLeading
        )
        headerItem.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [
            headerItem
        ]
        return section
    }

    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let sectionKind = Section(rawValue: sectionIndex) else {
                fatalError("no section at index ")
            }
            
            switch sectionKind {
            case .offers:
                return self.makeOfferSection()
    
            case .newRestaurants:
                return self.makeNewRestaurantSection()
                
            case .restaurants:
                return self.makeRestaurantSection()
            }
        }
        return layout
    }
}
// MARK: - UICollectionView Delegate
extension RestaurantViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.goToHome()
    }
}

// MARK: - UICollectionView Datasource
extension RestaurantViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section), let presenter = presenter else {
            fatalError("")
        }
        switch section {
        case .offers:
            return presenter.numberOfRowsInSectionOffer()
            
        case .newRestaurants:
            return presenter.numberOfRowsInSectionNewRestaurant()
            
        case .restaurants:
            return presenter.numberOfRowsInSectionRestaurant()
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionKind = Section(rawValue: indexPath.section) else {
            fatalError("")
        }
        guard let presenter = presenter else {
            return .init()
        }
        switch sectionKind {
        case .offers:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as OffersCollectionViewCell
            let offerModel = presenter.getOfferViewModel(at: indexPath)
            OffersCellBuilder.createCell(cell, offerViewModel: offerModel)
            return cell
            
        case .newRestaurants:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as NewRestaurantsCollectionViewCell
            let newRestaurant = presenter.getNewRestaurantViewModel(at: indexPath)
            NewRestaurantsCellBuilder.createCell(cell, newRestaurantViewModel: newRestaurant)
            return cell
            
        case .restaurants:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as RestaurantCollectionViewCell
            let restaurant = presenter.getResturantViewModel(at: indexPath)
            RestaurantsCellBuilder.createCell(cell, restaurantViewModel: restaurant)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch RestaurantKind(rawValue: kind) {
        case .basicHeader:
            let header = collectionView.dequeueSupplementaryView(ofKind: kind, for: indexPath, type: RestaurantHeaderView.self)
            RestaurantHeaderBuilder.createRestaurantHeaderModule(of: header)
            header.configureUI(with: indexPath)
            return header
            
        case .none:
            return UICollectionReusableView()
        }
    }
}

// MARK: - Presenter To View
extension RestaurantViewController: RestaurantPresenterOutputInterface {
    func configureRestaurantCollectionView() {
        restaurantCollectionView.registerWithNib(OffersCollectionViewCell.self, bundle: .module)
        restaurantCollectionView.registerWithNib(RestaurantCollectionViewCell.self, bundle: .module)
        restaurantCollectionView.registerWithNib(NewRestaurantsCollectionViewCell.self, bundle: .module)
    
        let collectionReusableViews = [
            RestaurantHeaderView.self
        ]
        let kinds: [RestaurantKind] = [
            .basicHeader
        ]

        for (collectionReusableView, kind) in zip(collectionReusableViews, kinds) {
            restaurantCollectionView.registerSupplementaryView(collectionReusableView, kind: kind.rawValue)
        }
        restaurantCollectionView.collectionViewLayout = createCompositionalLayout()
        restaurantCollectionView.dataSource = self
        restaurantCollectionView.delegate = self
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.restaurantCollectionView.reloadData()
        }
    }
}
