//
//  OnboardingViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 1.04.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - UI Properties
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    
    // MARK: - Presenter
    
    var presenter: ViewToPresenterOnboardingProtocol?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.configureViewModels()
        configureOnboardingCollectionView()
        configurePageControl()
    }
    
    // MARK: - Helper
    func configureOnboardingCollectionView() {
        onboardingCollectionView.bounces = false

        let nib = UINib(nibName: "OnboardingCollectionViewCell", bundle: nil)
        onboardingCollectionView.dataSource = self
        onboardingCollectionView.register(nib, forCellWithReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier)
        onboardingCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            // for each visible item, set the current pageValue -- stackoverflow
            section.visibleItemsInvalidationHandler = { items, contentOffset, environment in
                  let currentPage = Int(max(0, round(contentOffset.x / environment.container.contentSize.width)))
                  self.pageControl.currentPage = currentPage
            }
            return section
        }
        return layout
    }
    
    func configurePageControl() {
        pageControl.numberOfPages = presenter?.numberOfRowsInSection() ?? 0
        pageControl.currentPage = 0
        pageControl.backgroundStyle = .prominent
        pageControl.currentPageIndicatorTintColor = UIColor(named: "pageIndicator")!
        if #available(iOS 14.0, *){
            //3d touch for swing between screens are available
            pageControl.allowsContinuousInteraction = true
            pageControl.preferredIndicatorImage = #imageLiteral(resourceName: "orderFood")
            
        }
    }
    
    
    // MARK: - Action
    
    @IBAction func didPageControlValueChanged(_ sender: UIPageControl) {
        onboardingCollectionView.scrollToItem(at: .init(row: pageControl.currentPage, section: .zero), at: .centeredHorizontally, animated: true)
    }

    
}

// MARK: - Presenter To View

extension OnboardingViewController: PresenterToViewOnboardingProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.onboardingCollectionView.reloadData()
        }
    }
    func scrollToNextItem(at indexPath: IndexPath) {
        onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
}


// MARK: - OnboardingCollectionView Datasource

extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier, for: indexPath) as? OnboardingCollectionViewCell else { fatalError("Juniooooor")}
        cell.configureCell(with: (presenter?.getViewModel(at: indexPath))!)
        cell.delegate = self
        return cell
    }
    
    
}
// MARK: - OnboardingCollectionViewCellDelegate
extension OnboardingViewController: OnboardingCollectionViewCellDelegate {
    
    func didTapNextButton(_ cell: OnboardingCollectionViewCell) {
        let indexPath = onboardingCollectionView.indexPath(for: cell)
        presenter?.didUserTappedNextButton(at: indexPath)
    }
    
    
}
