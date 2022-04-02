//
//  ImageUploader.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import UIKit
import FirebaseStorage

class ImageUploader: ImageUploadable {
    
    private init () {}
    
    static let shared = ImageUploader()
    
    func uploadImage(image: UIImage, completion: @escaping imageUrlStringCompletion) {
        guard let jpegData = image.jpegData(compressionQuality: 0.7) else { return }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_photos/\(fileName)")
        ref.putData(jpegData, metadata: nil) { storageMetaData, error in
            if let error = error {
                completion(.failure(error))
            }
            ref.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                }
                guard let imageUrl = url?.absoluteString else { return }
                completion(.success(imageUrl))
            }
            
        }
    }
}
