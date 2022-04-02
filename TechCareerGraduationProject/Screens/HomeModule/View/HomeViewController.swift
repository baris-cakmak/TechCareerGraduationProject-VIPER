//
//  HomeViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import UIKit
import Lottie
import FirebaseAuth

class HomeViewController: UIViewController {
    
    // MARK: - UI Properties
    
    @IBOutlet weak var mealCollectionView: UICollectionView!
    
    private let mortyLoadingAnimation: AnimationView = {
        let animationView = AnimationView(animation: Animation.named("foodLoading"))
        animationView.animationSpeed = 3
        animationView.backgroundColor = UIColor(named: "blurBackground2")?.withAlphaComponent(0.7)
        animationView.loopMode = .loop
        return animationView
    }()
    
    // MARK: - Presenter
    
    var presenter: ViewToPresenterHomeProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMealCollectionView()
        presenter?.viewDidLoad()

    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.getMealsAtTheCart()
    }
    
    
    // MARK: - Helper
    
    func addMortyLoadingAnimationView() {
        view.addSubview(mortyLoadingAnimation)
        mortyLoadingAnimation.frame = view.bounds
        mortyLoadingAnimation.play()
    }
    
    func configureMealCollectionView() {
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        mealCollectionView.dataSource = self
        mealCollectionView.delegate = self
        mealCollectionView.register(nib, forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
        mealCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, enviroment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
            item.contentInsets.trailing = 20
            item.contentInsets.bottom = 20
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(255)), subitems: [item])
            group.contentInsets.leading = 20
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            return section
            
        }
    }
}

// MARK: - PresenterToView

extension HomeViewController: PresenterToViewHomeProtocol {

    func showLoadingAnimation() {
        DispatchQueue.main.async { [weak self] in
            self?.addMortyLoadingAnimationView()
        }
    }
    
    func removeLoadingAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self?.mortyLoadingAnimation.removeFromSuperview()

        })
    }
    
    func reloadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self?.mealCollectionView.reloadData()

        })
    }
    func updateBadgeCountOfCartTabBar(badgeValue: String?) {
        DispatchQueue.main.async {
                self.tabBarController?.viewControllers?[Constants.cartTabBarIndex].tabBarItem.badgeValue = badgeValue
        }
    }

}
// MARK: - MealCollectionView DataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfRowInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else { fatalError("Wish you were not a junior")}
        cell.configureModel(with: (presenter?.getViewModel(at: indexPath))!)
        return cell
    }
    
    
}

// MARK: - MealCollectionView Delegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.goToHomeDetail(with: indexPath)
    }
}



