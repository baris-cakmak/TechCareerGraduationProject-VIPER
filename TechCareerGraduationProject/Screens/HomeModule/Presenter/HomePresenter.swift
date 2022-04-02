//
//  HomePresenter.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 22.03.2022.
//

import Foundation

class HomePresenter: ViewToPresenterHomeProtocol {


    // MARK: - Presenter Obligations
    
    weak var view: PresenterToViewHomeProtocol?
    
    var interactor: PresenterToInteractorHomeProtocol?
    
    var router: PresenterToRouterHomeProtocol?
    
    
    // MARK: - ViewModel
    
    var mealViewModels: [MealViewModel]?

    // MARK: - Methods
    
    func viewDidLoad() {
        getViewModels()
    }
    
    func getViewModels() {
        view?.showLoadingAnimation()
        interactor?.getAllMeals()
    }
    
    func numberOfRowInSection() -> Int {
        mealViewModels?.count ?? 0
    }
    
    func getViewModel(at indexPath: IndexPath) -> MealViewModel {
        return mealViewModels![indexPath.row]
    
    }
    
    func goToHomeDetail(with indexPath: IndexPath) {
        guard let mealViewModels = mealViewModels else {
            return
        }

        router?.showHomeDetail(with: mealViewModels[indexPath.row])
    }
    
    func getMealsAtTheCart() {
        interactor?.fetchMealsAtTheCart()
    }
    
    
}

// MARK: - InteractorToPresenter

extension HomePresenter: InteractorToPresenterHomeProtocol {

    func didFetchAllMealsSuccessfully(responseModel: MealResponseModel) {
        let meal = responseModel.meal
        mealViewModels = meal.map { mealDto -> MealViewModel in
            return MealViewModel(mealName: mealDto.mealName,
                                 mealImageUrl: URL(string:  "\(Constants.apiImagesConstantUrlString)\(mealDto.mealImageUrl)") ?? Constants.somethingWentWrongUrl,
                                 mealPrice: mealDto.mealPrice,
                                 mealDesc: nil)
        }
        view?.removeLoadingAnimation()
        view?.reloadData()
    }
    
    func didFetchWithAnError(error: Error) {
        router?.showErrorPopUp(message: error.localizedDescription)
        view?.removeLoadingAnimation()
        view?.updateBadgeCountOfCartTabBar(badgeValue: nil)
    }
    
    func didFetchMealsAtTheCart(responseModel: MealCartResponseModel) {
        let mealCountAtTheCartText = responseModel.mealCart.count == 0 ? nil : "\(responseModel.mealCart.count)"
        view?.updateBadgeCountOfCartTabBar(badgeValue: mealCountAtTheCartText)
    }
    
    
}
