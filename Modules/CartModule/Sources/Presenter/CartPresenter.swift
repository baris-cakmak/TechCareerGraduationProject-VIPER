//
//  CartPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 25.03.2022.
//

import Foundation
import DependencyManagerKit
import UserStorageManagerKit
import CommonKit

protocol CartPresenterInterface {
    func viewDidLoad()
    func viewDidAppear()
    func viewWillAppear()
    func numberOfRowsInSection() -> Int
    func cartViewModel(at indexPath: IndexPath) -> CartViewModel
    func deleteMealFromTheCart(at indexPath: IndexPath?, with cartId: Int)
    func deleteAllItemsAtTheCart()
    func orderMealsAtTheCart()
    func didTapDeleteAll()
    func viewWillDisappear()
    func didErrorOccured(error: Error, isOkayToPresentTheError: Bool)
    func changeCartViewModel(at indexPath: IndexPath?, stepperCount: Double)
    func getAllThePricesInTheCart() -> [Int]
}

final class CartPresenter: CartPresenterInterface {
    weak private var view: CartPresenterOutputInterface?
    private let interactor: CartInteractorInterface?
    private let router: CartRouterInterface?
    
    private let userStorageManager: UserStorageManagerable?
    
    init(
        view: CartPresenterOutputInterface?,
        interactor: CartInteractorInterface?,
        router: CartRouterInterface?,
        userStorageManager: UserStorageManagerable?
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.userStorageManager = userStorageManager
    }
    
    private lazy var username = userStorageManager?.getUserEmailForMealAPI()
    private var cartViewModels: [CartViewModel] = []
}
// MARK: - Method

extension CartPresenter {
    func viewDidLoad() {
        view?.configureMealCollectionView()
        view?.configureBarButtonItem()
        view?.setNavigationItemTitle(with: Constants.NavigationItem.cartTitle)
    }
    func viewDidAppear() {
        view?.removeBadgeNumberFromTabBar()
    }
    func viewWillAppear() {
        view?.configureAnimation()
        interactor?.fetchMealsAtTheCart()
    }
    func viewWillDisappear() {
        interactor?.fetchMealsAtTheCartForBadgeValue()
    }
    func popBackIfNumberOfItemsEqualToZero() {
        cartViewModels.isEmpty ? router?.showFirstTabToAddMeal() : ()
    }
    func numberOfRowsInSection() -> Int {
        cartViewModels.count
    }
    
    func cartViewModel(at indexPath: IndexPath) -> CartViewModel {
        cartViewModels[indexPath.item]
    }
    func deleteMealFromTheCart(at indexPath: IndexPath?, with cartId: Int) {
        guard
            let indexPath = indexPath,
            let username = username else {
            return
        }
        interactor?.deleteSingleMeal(
            of: .init(
                username: username,
                cartId: cartId
            ),
            at: indexPath
        )
    }
    
    func deleteAllItemsAtTheCart() {
        if let username = username {
            view?.configureAnimation()
            let dispatchGroup = DispatchGroup()
            cartViewModels.forEach { cartViewModel in
                dispatchGroup.enter()
                interactor?.deleteAllMeals(of: .init(username: username, cartId: cartViewModel.cartId), dispatchGroup: dispatchGroup)
            }
            dispatchGroup.notify(queue: .main) {
                self.cartViewModels = []
                self.view?.removeAnimation()
                self.popBackIfNumberOfItemsEqualToZero()
            }
        }
    }
    
    func orderMealsAtTheCart() {
        router?.showOrderDecisionPopUp()
    }
    func didTapDeleteAll() {
        router?.showDeleteDecisionPopUp()
    }
    func didErrorOccured(error: Error, isOkayToPresentTheError: Bool = true) {
        popBackIfNumberOfItemsEqualToZero()
        isOkayToPresentTheError ?
        router?.showAlert(message: error.localizedDescription) : ()
    }
    func getAllThePricesInTheCart() -> [Int] {
        cartViewModels.map {
            $0.mealPrice * Int($0.stepperCurrentValue)
        }
    }
    func changeCartViewModel(at indexPath: IndexPath?, stepperCount: Double) {
        if let indexPath = indexPath {
            cartViewModels[indexPath.item].stepperCurrentValue = stepperCount
            view?.updateCheckoutFooterPrice()
        }
    }
}

// MARK: - Helper
extension CartPresenter {
    private func makeCartViewModel(with cartMeals: [MealCart]) throws {
        try cartViewModels = cartMeals.map { cartMeal in
            guard
                let mealId = Int(cartMeal.cartMealId),
                let stepperCurrentValue = Double(cartMeal.cartMealOrderCount),
                let pricePerItem = Int(cartMeal.cartMealPrice) else {
                throw GeneralErrors.invalidId
            }
            return .init(
                cartId: mealId,
                mealName: cartMeal.cartMealName,
                mealPrice: pricePerItem,
                mealImageUrl: .init(
                    string: cartMeal.cartMealImageName
                ),
                mealDescription: "Price Per Item is \(cartMeal.cartMealPrice)",
                stepperCurrentValue: stepperCurrentValue,
                totalPrice: calculateTotalPrice(
                    count: stepperCurrentValue,
                    pricePerItem: pricePerItem
                ),
                stepperLeftButtonText: handleStepperStatus(orderCount: stepperCurrentValue)
            )
        }
    }
}
// MARK: - Interactor To Presenter
protocol CartInteractorOutputInterface: AnyObject {
    func didFetchMealsAtTheCart(result: Result<MealCartResponseModel, Error>)
    func didDeleteMeals(result: Result<MealSuccessResponseModel, Error>, at indexPath: IndexPath)
    func didFetchMealsAtTheCartForBadge(result: Result<MealCartResponseModel, Error>)
}

extension CartPresenter: CartInteractorOutputInterface {
    func didDeleteMeals(result: Result<MealSuccessResponseModel, Error>, at indexPath: IndexPath) {
        view?.removeAnimation()
        switch result {
        case .success:
            view?.deleteItems(at: indexPath)
            cartViewModels.remove(at: indexPath.item)
            view?.updateCheckoutFooterPrice()
            self.popBackIfNumberOfItemsEqualToZero()
            
        case .failure(let error):
            didErrorOccured(error: error)
        }
    }
    
    func didFetchMealsAtTheCart(result: Result<MealCartResponseModel, Error>) {
        view?.removeAnimation()
        switch result {
        case .success(let mealCartReponse):
            do {
                try makeCartViewModel(with: mealCartReponse.mealCart)
            } catch {
                didErrorOccured(error: error, isOkayToPresentTheError: false)
                return
            }
            view?.reloadData()
            
        case .failure(let error):
            didErrorOccured(error: error, isOkayToPresentTheError: false)
        }
    }
    
    func didFetchMealsAtTheCartForBadge(result: Result<MealCartResponseModel, Error>) {
        switch result {
        case .success(let mealCartResponse):
            let badgeText = mealCartResponse.mealCart.isEmpty ? nil : "\(mealCartResponse.mealCart.count)"
            view?.updateBadgeValueOfCartTabBar(badgeText)
            
        case .failure(let error):
            didErrorOccured(error: error, isOkayToPresentTheError: false)
        }
    }
}

// MARK: - Router To Presenter

protocol RouterToPresenterCartProtocol: AnyObject {
    func didUserDecidedToGetTheOrder()
    func didDeleteAllRequested()
}

extension CartPresenter: RouterToPresenterCartProtocol {
    func didDeleteAllRequested() {
        deleteAllItemsAtTheCart()
    }
    
    func didUserDecidedToGetTheOrder() {
        deleteAllItemsAtTheCart()
    }
}

// MARK: - Cart Item Changable
extension CartPresenter: CartItemChangable {
}
