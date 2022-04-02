//
//  CartViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 25.03.2022.
//

import UIKit
import GMStepper
import Lottie

class CartViewController: UIViewController {

    // MARK: - UI Properties

    @IBOutlet weak var cartCollectionView: UICollectionView!
    
    private let animation: AnimationView = {
        let aV = AnimationView()
        aV.loopMode = .loop
        return aV
    }()
    
    // MARK: - Presenter
    
    var presenter: ViewToPresenterCartProtocol?
    
    // MARK: - Lifecycle


    override func viewDidLoad() {
        super.viewDidLoad()
        configureMealCollectionView()
        configureBarButtonItem()
        


    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeBadgeNumberFromTabBar()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()

    }
    
    // MARK: - Helper
    
    // might shift to presenter
    func configureAnimation(named: Animations) {
        animation.animation = Animation.named(named.rawValue)
        // add animation on view
        animation.backgroundColor = UIColor(named: "blurBackground2")!
        view.addSubview(animation)
        animation.frame = view.bounds
        animation.play()
        
    }

    func configureMealCollectionView() {
        let nib = UINib(nibName: "CartCollectionViewCell", bundle: nil)
        let footerNib = UINib(nibName: "CartFooterCollectionReusableView", bundle: nil)
        cartCollectionView.dataSource = self
        cartCollectionView.delegate = self
        cartCollectionView.register(nib, forCellWithReuseIdentifier: CartCollectionViewCell.reuseIdentifier)
        cartCollectionView.register(footerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CartFooterCollectionReusableView.identifier)
        cartCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    func configureBarButtonItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "delete"), style: .done, target: self, action: #selector(didTapDeleteBarButtonItem))

    }
    
    func removeBadgeNumberFromTabBar() {
        self.tabBarController?.tabBar.selectedItem?.badgeValue = nil

    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, enviroment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets.trailing = 20
            item.contentInsets.bottom = 10
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.4)), subitems: [item])
            group.contentInsets.leading = 20
            let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .absolute(60))
            let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.boundarySupplementaryItems = [footer]
            return section
            
        }
    }
    
    // MARK: - Action
    
    @objc
    func didTapDeleteBarButtonItem() {
        presenter?.didTapDeleteAll()
    }

}


// MARK: - PresenterToView

extension CartViewController: PresenterToViewCartProtocol {
    
    func updateCheckoutFooterPrice() {
        if let visibleFooter = cartCollectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionFooter).first as? CartFooterCollectionReusableView {
            DispatchQueue.main.async {
                visibleFooter.priceLabel.alpha = 0
                visibleFooter.priceLabel.text = self.presenter?.calculateTotalPrice()
                visibleFooter.priceLabel.fadeIn(duration: 1.1, delay: 0.1) { (finished: Bool) -> Void in}
            }
        }
        
    }
    
    
    func deleteItems(at indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.cartCollectionView.deleteItems(at: [indexPath])
        }
        
    }
    
    func showLoadingAnimation(with animation: Animations) {
        configureAnimation(named: animation)
    }
    
    func removeLoadingAnimation() {
        DispatchQueue.main.async {
            self.animation.removeFromSuperview()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.cartCollectionView.reloadData()
        }
    }
    
    func reloadItems(at indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.cartCollectionView.reloadItems(at: [indexPath])
            

        }
 	
    }
    
    
}

// MARK: - CartCollectionView Datasource

extension CartViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (presenter?.numberOfRowsInSection())!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCollectionViewCell.reuseIdentifier, for: indexPath) as? CartCollectionViewCell else { fatalError("Why so junior?")}
        cell.configureCell(with: (presenter?.cartViewModel(at: indexPath))!)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CartFooterCollectionReusableView.identifier, for: indexPath) as! CartFooterCollectionReusableView
        footerView.delegate = self
        footerView.priceLabel.text = presenter?.calculateTotalPrice()
        
        return footerView

    }
    
}

// MARK: - CartCollectionView Delegate

extension CartViewController: UICollectionViewDelegate {

}

// MARK: - CartCollectionViewCell Delegate

extension CartViewController: CartCollectionViewCellDelegate {
    
    func didStepperValueChanged(_ stepper: GMStepper, stepperValue: Double, for cell: CartCollectionViewCell) {
        let indexPath = cartCollectionView.indexPath(for: cell)
        presenter?.calculateMealPriceByStepper(stepperValue: stepperValue, indexPath: indexPath)
        if let visibleFooter = cartCollectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionFooter).first as? CartFooterCollectionReusableView {
            DispatchQueue.main.async {
                visibleFooter.priceLabel.fadeOut()
                visibleFooter.priceLabel.text = self.presenter?.calculateTotalPrice()
                visibleFooter.priceLabel.fadeIn(duration: 0.5, delay: 0.1) { (finished: Bool) -> Void in}
            }
        }
        
        
    }
    
    func didTapDeleteButton(for cell: CartCollectionViewCell) {
        let indexPath = cartCollectionView.indexPath(for: cell)
        presenter?.deleteMealFromTheCart(at: indexPath)
    }

}

// MARK: - CartFooterCollectionReusableViewDelegate

extension CartViewController: CartFooterCollectionReusableViewDelegate {
    
    func didTapOrderNow() {
        presenter?.orderMealsAtTheCart()
    }
}
