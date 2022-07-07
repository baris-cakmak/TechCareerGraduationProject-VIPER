//
//  CartViewController.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 25.03.2022.
//

import UIKit
import GMStepper
import LottieAnimationConfigurableKit
import CommonKit
import Lottie

typealias CartInterface = LottieAnimationConfigurable & NavigationItemUpdatable

protocol CartPresenterOutputInterface: AnyObject, CartInterface {
    func configureBarButtonItem()
    func configureMealCollectionView()
    func reloadData()
    func reloadItems(at indexPath: IndexPath)
    func deleteItems(at indexPath: IndexPath)
    func updateCheckoutFooterPrice()
    func updateBadgeValueOfCartTabBar(_ value: String?)
    func removeBadgeNumberFromTabBar()
}

final class CartViewController: UIViewController {
    // MARK: - UI Properties
    
    @IBOutlet weak private var cartCollectionView: UICollectionView!
    
    private(set) var animationView: AnimationView? = {
        let aV = AnimationView()
        aV.animation = Animation.named(CartViewConstants.animationName)
        aV.backgroundColor = CartViewConstants.animationBackgroundColor
        aV.loopMode = .loop
        return aV
    }()
    
    // MARK: - Presenter
    
    var presenter: CartPresenterInterface?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeBadgeNumberFromTabBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
}
// MARK: - Constant
extension CartViewController {
    private enum CartViewConstants {
        static let animationName: String = Animations.cartLoading.rawValue
        static let animationBackgroundColor: UIColor = .named("blurBackground2")
        static let groupWidthFraction: CGFloat = 0.4
        static let footerHeightSize: CGFloat = 60
        static let deleteBarButtonImage: UIImage = .named("delete")
    }
}
// MARK: - Helper
extension CartViewController {
    // swiftlint: disable closure_body_length
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
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
                    heightDimension: .fractionalWidth(CartViewConstants.groupWidthFraction)
                ),
                subitems: [item]
            )
            group.contentInsets.leading = Constants.Layout.tooGeneralInsetConstant
            let footerHeaderSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(Constants.Layout.fullFraction),
                heightDimension: .absolute(CartViewConstants.footerHeightSize)
            )
            let footer = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerHeaderSize,
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.boundarySupplementaryItems = [footer]
            return section
        }
    }
}
// MARK: - Action
extension CartViewController {
    @objc
    private func didTapDeleteBarButtonItem() {
        presenter?.didTapDeleteAll()
    }
}
// MARK: - PresenterToView

extension CartViewController: CartPresenterOutputInterface {
    func configureMealCollectionView() {
        cartCollectionView.dataSource = self
        cartCollectionView.registerWithNib(CartCollectionViewCell.self, bundle: .module)
        cartCollectionView.registerSupplementaryViewWithNib(
            CartFooterCollectionReusableView.self,
            kind: UICollectionView.elementKindSectionFooter,
            bundle: .module
        )
        cartCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    func removeBadgeNumberFromTabBar() {
        tabBarController?.tabBar.selectedItem?.badgeValue = nil
    }
    func configureBarButtonItem() {
        navigationItem.rightBarButtonItem = .init(
            image: CartViewConstants.deleteBarButtonImage,
            style: .done,
            target: self,
            action: #selector(didTapDeleteBarButtonItem)
        )
    }
    
    func updateCheckoutFooterPrice() {
        if
            let visibleFooter = cartCollectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionFooter).first as? CartFooterCollectionReusableView, let presenter = presenter {
            visibleFooter.calculateTotalPrice(of: presenter.getAllThePricesInTheCart())
        }
    }
    
    func deleteItems(at indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.cartCollectionView.deleteItems(at: [indexPath])
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
    func updateBadgeValueOfCartTabBar(_ value: String?) {
        tabBarController?.viewControllers?[Constants.TabBar.cartTabBarIndex].tabBarItem.badgeValue = value
    }
}

// MARK: - CartCollectionView Datasource

extension CartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else {
            return .zero
        }
        return presenter.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else {
            return .init()
        }
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CartCollectionViewCell
        let cartViewModel = presenter.cartViewModel(at: indexPath)
        CartCollectionViewCellBuilder.createCartCollectionViewModule(using: cell, delegate: self, cartViewModel: cartViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let presenter = presenter else {
            return .init()
        }
        guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CartFooterCollectionReusableView.identifier, for: indexPath) as? CartFooterCollectionReusableView else {
            fatalError("Footerview Error")
        }
        CartFooterBuilder.createFooter(of: footerView, delegate: self)
        footerView.calculateTotalPrice(of: presenter.getAllThePricesInTheCart())
        return footerView
    }
}

// MARK: - CartCollectionViewCell Delegate

extension CartViewController: CartCollectionViewCellDelegate {
    func updateFooterForNewTotalPrice(for cell: CartCollectionViewCellInterface, value: Double) {
        let indexPath = cartCollectionView.indexPath(for: cell)
        presenter?.changeCartViewModel(at: indexPath, stepperCount: value)
    }
    func didUserDecidedToDeleteMeal(for cell: CartCollectionViewCellInterface, by cartId: Int) {
        let indexPath = cartCollectionView.indexPath(for: cell)
        presenter?.deleteMealFromTheCart(at: indexPath, with: cartId)
    }
}
// MARK: - CartFooterCollectionReusableViewDelegate

extension CartViewController: CartFooterCollectionReusableViewDelegate {
    func didTapOrderNow() {
        presenter?.orderMealsAtTheCart()
    }
}
