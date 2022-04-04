//
//  CartPresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 25.03.2022.
//

import Foundation

class CartPresenter: ViewToPresenterCartProtocol {
    
    var view: PresenterToViewCartProtocol?
    
    var interactor: PresenterToInteractorCartProtocol?
    
    var router: PresenterToRouterCartProtocol?
    
    let username = UserStorageManager.shared.getUserEmailForMealAPI()
    
    var cartViewModels: [CartViewModel]? {
        didSet {
            view?.reloadData()
        }
    }
    
    // MARK: - Method
    
    func viewWillAppear() {
        getMealsAtTheCart()
        
    }
    func viewWillDisappear() {
        interactor?.fetchMealsAtTheCartForBadgeValue()
    }
    
    func popBackIfNumberOfItemsEqualToZero() {
        print("debug: cartviewmodels", cartViewModels)
        self.cartViewModels == nil || self.cartViewModels!.isEmpty ? self.router?.showFirstTabToAddMeal() : ()
    }
    
    func calculateTotalPrice() -> String{
        var totalPrice = 0
        if let cartViewModels = cartViewModels {
            cartViewModels.forEach({ viewModel in
                totalPrice += Int(viewModel.totalPrice)!
            })
        }
        return "₺ \(totalPrice)"
        
    }
    
    func getMealsAtTheCart() {
        view?.showLoadingAnimation(with: .cartLoading)
        interactor?.fetchMealsAtTheCart()
    }
    
    func numberOfRowsInSection() -> Int {
        guard let cartViewModels = cartViewModels else {
            return 0
        }
        return cartViewModels.count
    }
    
    
    func updateLeftLabelByStepperValue(_ stepperValue: Double) -> String {
        return stepperValue != 1 ? "-" : "🥺"
    }
    
    func handleStepperValue(_ stepperValue: Double, at indexPath: IndexPath) {
        
        cartViewModels?[indexPath.item].stepperLeftLabel = updateLeftLabelByStepperValue(stepperValue)
        if stepperValue == 0 {
            
            interactor?.deleteSingleMeal(of: MealDeleteRequestModel(username: username, cartId: (cartViewModels?[indexPath.item].cartId)!), at: indexPath)
        }
        
    }
    
    func cartViewModel(at indexPath: IndexPath) -> CartViewModel {
        return cartViewModels![indexPath.item]
    }
    
    func calculateMealPriceByStepper(stepperValue: Double, indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        handleStepperValue(stepperValue, at: indexPath)
        let mealPrice = cartViewModels?[indexPath.item].mealPrice
        let totalPrice: Int = Int(stepperValue) * Int(mealPrice!)!
        cartViewModels?[indexPath.item].totalPrice = "\(totalPrice)"
        cartViewModels?[indexPath.item].stepperCurrentValue = stepperValue
        view?.reloadItems(at: indexPath)
        
    }
    
    
    func deleteMealFromTheCart(at indexPath: IndexPath?) {
        guard let indexPath = indexPath,
              let cartViewModels = cartViewModels
        else {
            return
        }
        interactor?.deleteSingleMeal(of: MealDeleteRequestModel(username: username,
                                                                cartId: cartViewModels[indexPath.item].cartId), at: indexPath)
    }
    
    func deleteAllItemsAtTheCart() {
        // Reminder..Since multiple requests will occur in network, use dispatch groups(or any other relaated solution).
        view?.showLoadingAnimation(with: .cartLoading)
        let dispatchGroup = DispatchGroup()
        cartViewModels?.forEach({ cartViewModel in
            dispatchGroup.enter()

            interactor?.deleteAllMeals(of: MealDeleteRequestModel(username: username, cartId: cartViewModel.cartId), dispatchGroup: dispatchGroup)
            
//            dispatchGroup.leave()
        })
        dispatchGroup.notify(queue: .main) {
            self.cartViewModels = []
            self.view?.removeLoadingAnimation()
            self.popBackIfNumberOfItemsEqualToZero()

        }
        
    }
    
    func orderMealsAtTheCart() {
        self.router?.showOrderDecisionPopUp()
    }
    func didTapDeleteAll() {
        self.router?.showDeleteDecisionPopUp()
    }
}
// MARK: - Interactor To Presenter
extension CartPresenter: InteractorToPresenterCartProtocol {
    
    func didErrorOccured(error: Error) {
        print("debug: cartNetworkError \(error)")
        view?.removeLoadingAnimation()
        popBackIfNumberOfItemsEqualToZero()
        
    }
    
    func didFetchMealsAtTheCartSuccessfully(_ mealCartReponse: MealCartResponseModel) {
        let mealCart = mealCartReponse.mealCart
        cartViewModels =  mealCart.map({ (mealCartModel) -> CartViewModel in
            let currentTotalPrice = Int(mealCartModel.cartMealPrice)! * Int(mealCartModel.cartMealOrderCount)!
            return CartViewModel(cartId: Int(mealCartModel.cartMealId)!,
                                 mealName: mealCartModel.cartMealName,
                                 mealPrice: mealCartModel.cartMealPrice,
                                 mealImageUrl: URL(string: mealCartModel.cartMealImageName)!,
                                 stepperCurrentValue: Double(mealCartModel.cartMealOrderCount)!,
                                 totalPrice: "\(currentTotalPrice)",
                                 stepperLeftLabel: updateLeftLabelByStepperValue(Double(mealCartModel.cartMealOrderCount)!))
            
        })
        view?.removeLoadingAnimation()
        view?.reloadData()
        
    }
    
    func didDeleteSuccessfully(at indexPath: IndexPath) {
        view?.removeLoadingAnimation()
        view?.deleteItems(at: indexPath)
        cartViewModels?.remove(at: indexPath.item)
        view?.updateCheckoutFooterPrice()
        self.popBackIfNumberOfItemsEqualToZero()
        
    }
    

    
    func didFetchMealsAtTheCartForBadge(_ mealCartResponse: MealCartResponseModel) {
        let badgeText = mealCartResponse.mealCart.count == 0 ? nil : "\(mealCartResponse.mealCart.count)"
        view?.updateBadgeValueOfCartTabBar(badgeText)
    }
    
}


// MARK: - Router To Presenter

extension CartPresenter: RouterToPresenterCartProtocol {

    func didDeleteAllRequested() {
        deleteAllItemsAtTheCart()
    }
    
    
    func didUserDecidedToGetTheOrder() {
        deleteAllItemsAtTheCart()
    }
}
