//
//  RestaurantViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 3.04.2022.
//

import UIKit
import Lottie

class RestaurantViewController: UIViewController {
        
    // MARK: - Preesenter
    
    var presenter: ViewToPresenterRestaurantProtocol?
    
    // MARK: - UI Properties
    
    @IBOutlet weak var restaurantCollectionView: UICollectionView!
    
    private let animationView: AnimationView = {
        let animation = Animation.named(Animations.userLoading.rawValue)
        let aV = AnimationView(animation: animation)
        aV.loopMode = .loop
        aV.animationSpeed = 3
        aV.backgroundColor = UIColor(named: "blurBackground2")?.withAlphaComponent(0.75)
        return aV
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRestaurantCollectionView()
        presenter?.viewDidLoad()
 
        
    }
    // MARK: - Helper
    
    func configureRestaurantCollectionView() {
        let offerNib = UINib(nibName: "OffersCollectionViewCell", bundle: nil)
        let newRestaurantsNib = UINib(nibName: "NewRestaurantsCollectionViewCell", bundle: nil)
        let restaurantNib = UINib(nibName: "RestaurantCollectionViewCell", bundle: nil)
        restaurantCollectionView.register(restaurantNib, forCellWithReuseIdentifier: RestaurantCollectionViewCell.reuseIdentifier)
        restaurantCollectionView.register(offerNib, forCellWithReuseIdentifier:  OffersCollectionViewCell.reuseIdentifier)
        restaurantCollectionView.register(newRestaurantsNib, forCellWithReuseIdentifier: NewRestaurantsCollectionViewCell.reuseIdentifier)
        restaurantCollectionView.collectionViewLayout = createCompositionalLayout()
        restaurantCollectionView.dataSource = self
        restaurantCollectionView.delegate = self
        restaurantCollectionView.register(RestaurantHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RestaurantHeaderView.identifier)
        
    }
    
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { fatalError("no section at index ")}
            
            switch sectionKind {
            case .offers:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.bottom = 20
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(230)), subitems: [item])
                group.contentInsets.leading = 10
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                    items.forEach { item in
                        let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                        let minScale: CGFloat = 0.8
                        let maxScale: CGFloat = 1.05
                        let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                        item.transform = CGAffineTransform(scaleX: scale, y: scale)
                    }
                }
                return section
            case .newRestaurants:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 20
                item.contentInsets.bottom = 20
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
                group.contentInsets.leading = 20
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 20
                section.orthogonalScrollingBehavior = .none
                section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                    items.forEach { item in
                        let distanceFromCenter = abs((item.frame.midY - offset.y) - environment.container.contentSize.height / 2.0)
                        let minScale: CGFloat = 0.87
                        let maxScale: CGFloat = 1.1
                        let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.height), minScale)
                        item.transform = CGAffineTransform(scaleX: scale, y: scale)
                    }
                }
                
                let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
                headerItem.pinToVisibleBounds = true
                section.boundarySupplementaryItems = [
                    headerItem
                ]
                
                return section
            case .restaurants:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 20
                item.contentInsets.bottom = 20
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(270)), subitems: [item])
                group.contentInsets.leading = 20
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 20
                section.orthogonalScrollingBehavior = .none
 
                let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
                headerItem.pinToVisibleBounds = true
                section.boundarySupplementaryItems = [
                    headerItem
                ]
                
                return section
            }
            
        }
        return layout
    }

}

// MARK: - UICollectionView Delegate
extension RestaurantViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.section)
        presenter?.goToHome()
    }
}

// MARK: - UICollectionView Datasource

extension RestaurantViewController: UICollectionViewDataSource {

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // TODO: - I do not have enough time for nested api.. Separate each endpoint and load them individually. After the assignment, check for the "Diffable Data Source" and Api Response with sections and so on..
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {fatalError("")}
        switch section {
        case .offers:
            return (presenter?.numberOfRowInSectionOffer())!
        case .newRestaurants:
            return (presenter?.numberOfRowInSectionNewRestaurant())!
        case .restaurants:
            return (presenter?.numberOfRowsInSectionRestaurant())!
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sectionKind = Section(rawValue: indexPath.section) else {fatalError("")}
        switch sectionKind {
        case .offers:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OffersCollectionViewCell.reuseIdentifier, for: indexPath) as! OffersCollectionViewCell
            cell.configureCell(with: (presenter?.getOfferViewModel(at: indexPath))!)
            return cell
        case .newRestaurants:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewRestaurantsCollectionViewCell.reuseIdentifier, for: indexPath) as! NewRestaurantsCollectionViewCell
            cell.configureCell(with: (presenter?.getNewRestaurantViewModel(at: indexPath))!)
            return cell
        case .restaurants:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.reuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell
            cell.configureCell(with: (presenter?.getRestaurantViewModel(at: indexPath))!)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionKind = Section(rawValue: indexPath.section) else {fatalError("")}
        switch sectionKind {
        case .offers:
            return UICollectionReusableView()
        case .newRestaurants:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RestaurantHeaderView.identifier, for: indexPath) as! RestaurantHeaderView
            
            header.configureReusableView(with: "\(Section.newRestaurants)".titleCased())
            header.backgroundColor = UIColor(named: "blurBackground3")!
            return header
        case .restaurants:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RestaurantHeaderView.identifier, for: indexPath) as! RestaurantHeaderView
            
            header.configureReusableView(with: "\(Section.restaurants)".titleCased())
            header.backgroundColor = UIColor(named: "blurBackground3")!
            return header
        }

    }
}


// MARK: - Presenter To View
extension RestaurantViewController: PresenterToViewRestaurantProtocol {
    func showLoadingAnimation() {
        view.addSubview(animationView)
        animationView.frame = view.bounds
        animationView.play()
    }
    
    func removeLoadingAnimation() {
        DispatchQueue.main.async {
            self.animationView.removeFromSuperview()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.restaurantCollectionView.reloadData()
        }
    }
    
    
}

