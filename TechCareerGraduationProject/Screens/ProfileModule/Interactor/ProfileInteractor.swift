//
//  ProfileInteractor.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 31.03.2022.
//

import Foundation
import FirebaseAuth

class ProfileInteractor: PresenterToInteractorProfileProtocol {

    var presenter: InteractorToPresenterProfileProtocol?
    
    private let userManager: UserManagerProvider?
    
    init(userManager: UserManagerProvider){
        self.userManager = userManager
    }
    
    // MARK: - Method
    
    func fetchUser() {
        do {
            try userManager?.fetchUser(completion: { [presenter] result in
                switch result {
                case .success(let user):
                    presenter?.didfetchUser(user)
                case .failure(let error):
                    presenter?.didErrorOccured(error)
                }
            })
        } catch {
            presenter?.didErrorOccured(error)
        }
        
    }
    
    func logoutTheUser() {
        do {
            try Auth.auth().signOut()
            presenter?.didUserLogout()
        } catch {
            presenter?.didErrorOccured(error)
        }
    }
    
}
