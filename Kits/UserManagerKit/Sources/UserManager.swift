//
//  UserManager.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import UserStorageManagerKit
import ImageUploaderKit
import CommonKit
import DependencyManagerKit

public protocol UserManagerProvider {
    typealias Parameters = [String: Any]
    
    func logUserIn(with email: String, and password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchUser(completion: @escaping (Result<CommonKit.UserInfo, Error>) -> Void)
    func logOut(completion: @escaping (Result<Void, Error>) -> Void)
}

public final class UserManager {
    @Dependency var userStorageManager: UserStorageManagerable
    public init() {}
}

// MARK: - Constnant
private enum UserManagerConstants {
    static let userCollection = Firestore.firestore().collection("users")
}
// MARK: - UserManager Provider
extension UserManager: UserManagerProvider {
    // TODO: - Convert the uid and Dictionary type adding data to Codable later on

    public func logUserIn(with email: String, and password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                try? Auth.auth().signOut()
                completion(.failure(error))
            }
            guard let userEmail = authDataResult?.user.email else {
                return
            }
            self.userStorageManager.setUserEmailForMealAPI(username: userEmail)
            completion(.success(()))
        }
    }
    
    public func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping (Result<Void, Error>) -> Void) {
        ImageUploader.shared.uploadImage(image: credentials.profileImage) { result in
            switch result {
            case.success(let imageStringInFirebaseStorage):
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { dataResult, error in
                    if let error = error {
                        completion(.failure(error))
                    }
                    guard let uid = dataResult?.user.uid else {
                        return
                    }
                    let dataToStore: Parameters =
                    [
                        "email": credentials.email,
                        "profileImageUrl": imageStringInFirebaseStorage,
                        "uid": uid,
                        "username": credentials.username
                    ]
                    UserManagerConstants.userCollection.document(uid).setData(dataToStore) { error in
                        if let error = error {
                            try? Auth.auth().signOut()
                            completion(.failure(error))
                            return
                        }
                        completion(.success(()))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchUser(completion: @escaping (Result<CommonKit.UserInfo, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(UserManagerError.noUser))
            return
        }
        UserManagerConstants.userCollection.document(uid).getDocument { snapshotData, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let dictionaryResponseData = snapshotData?.data() else {
                return
            }
            let user = UserInfo(dictionary: dictionaryResponseData)
            completion(.success(user))
        }
    }
    
    public func logOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
