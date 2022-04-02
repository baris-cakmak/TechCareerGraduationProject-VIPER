//
//  UserManager.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class UserManager: UserManagerProvider {
    // TODO: - Convert the uid and Dictionary type adding data to Codable later on
    
    func logUserIn(with email: String, and password: String, completion: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping (Error?) -> Void) {
        // upload image to storage, register the user in firestore, use email,password and username from user input
        ImageUploader.shared.uploadImage(image: credentials.profileImage) { result in
            switch result {
                case.success(let imageStringInFirebaseStorage):
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { dataResult, error in
                    if let error = error {
                        completion(error)
                    }
                    guard let uid = dataResult?.user.uid else { return }
                    let dataToStore: Parameters =
                    [
                        "email" : credentials.email,
                        "profileImageUrl" : imageStringInFirebaseStorage,
                        "uid" : uid,
                        "username" : credentials.username
                    ]
                    Constants.usersCollection.document(uid).setData(dataToStore, completion: completion)
                }
                case .failure(let error):
                completion(error)
            }
        }
        
    }
    
    func fetchUser(completion: @escaping (Result<User, Error>) -> Void) throws {
        guard let uid = Auth.auth().currentUser?.uid else { throw UserManagerError.noUser }
        // get the specific user with uid that is generated in register part
        Constants.usersCollection.document(uid).getDocument { snapshotData, error in
            // return type of snapshot is dictionary as well as in register
            if let error = error {
                completion(.failure(error))
            }
            // get the dict data
            guard let dictionaryResponseData = snapshotData?.data() else { return }
            let user = User(dictionary: dictionaryResponseData)
            completion(.success(user))
        }
        
    }
    
    
}
