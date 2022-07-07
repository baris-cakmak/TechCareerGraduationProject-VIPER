//
//  OnboardingViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 1.04.2022.
//

import UIKit
import CommonKit

protocol OnboardingPresenterOutputInterface: AnyObject {
    func configureOnboardingCollectionView()
    func configurePageControl()
    func reloadData()
    func scrollToNextItem(at indexPath: IndexPath)
}

final class OnboardingViewController: UIViewController {
    // MARK: - UI Properties
    
    @IBOutlet weak private var pageControl: UIPageControl!
    @IBOutlet weak private var onboardingCollectionView: UICollectionView!
    
    // MARK: - Presenter
    
    var presenter: OnboardingPresenterInterface?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}
// MARK: - Constant
extension OnboardingViewController {
    private enum OnboardingConstants {
        static let pageControlIndicatorTintColor: UIColor = .named("pageIndicator")
        static let pageControlPrefferedIndicatorImage: UIImage = .named("orderFood")
    }
}
// MARK: - Helper
extension OnboardingViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { _, environment in
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(Constants.Layout.fullFraction),
                    heightDimension: .fractionalHeight(Constants.Layout.fullFraction)
                )
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(Constants.Layout.fullFraction),
                    heightDimension: .fractionalHeight(Constants.Layout.fullFraction)
                ),
                subitems: [item]
            )
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.visibleItemsInvalidationHandler = { _, contentOffset, environment in
                let currentPage = Int(max(.zero, round(contentOffset.x / environment.container.contentSize.width)))
                self.pageControl.currentPage = currentPage
            }
            return section
        }
        return layout
    }
}
// MARK: - Action
extension OnboardingViewController {
    @IBAction private func didPageControlValueChanged(_ sender: UIPageControl) {
        onboardingCollectionView.scrollToItem(at: .init(row: pageControl.currentPage, section: .zero), at: .centeredHorizontally, animated: true)
    }
}
// MARK: - Presenter To View

extension OnboardingViewController: OnboardingPresenterOutputInterface {
    func configurePageControl() {
        pageControl.numberOfPages = presenter?.numberOfItemsInSection() ?? .zero
        pageControl.currentPage = .zero
        pageControl.backgroundStyle = .prominent
        pageControl.currentPageIndicatorTintColor = OnboardingConstants.pageControlIndicatorTintColor
        if #available(iOS 14.0, *) {
            pageControl.allowsContinuousInteraction = true
            pageControl.preferredIndicatorImage = OnboardingConstants.pageControlPrefferedIndicatorImage
        }
    }
    func configureOnboardingCollectionView() {
        onboardingCollectionView.bounces = false
        onboardingCollectionView.dataSource = self
        onboardingCollectionView.registerWithNib(OnboardingCollectionViewCell.self, bundle: OnboardingModuleResources.bundle)
        onboardingCollectionView.collectionViewLayout = createCompositionalLayout()
    }
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
        presenter?.numberOfItemsInSection() ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as OnboardingCollectionViewCell
        let onboardingViewModel = presenter.getViewModel(at: indexPath)
        OnboardingCellBuilder.createCell(cell, onboardingViewModel: onboardingViewModel, delegate: self)
        return cell
    }
}
// MARK: - OnboardingCollectionViewCellDelegate
extension OnboardingViewController: OnboardingCollectionViewCellDelegate {
    func didTapNextButton(_ cell: OnboardingCellInterface) {
        if let cell = cell as? UICollectionViewCell {
            let indexPath = onboardingCollectionView.indexPath(for: cell)
            presenter?.didUserTappedNextButton(at: indexPath)
        }
    }
}
