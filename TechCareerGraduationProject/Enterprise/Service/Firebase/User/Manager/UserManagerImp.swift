//
//  UserManagerImp.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import Foundation
import Firebase

protocol UserManagerProvider {
    
    typealias Parameters = [String: Any]
    
    func logUserIn(with email: String, and password: String, completion: @escaping AuthDataResultCallback)
    func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping (Error?) -> Void)
    func fetchUser(completion: @escaping (Result<User,Error>) -> Void) throws

}
