//
//  ImageUploader.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import UIKit.UIImage
import Firebase
import FirebaseStorage

public protocol ImageUploadable {
    typealias ImageUrlStringCompletion = (Result<String, Error>) -> Void
    func uploadImage(image: UIImage, completion: @escaping ImageUrlStringCompletion)
}

public final class ImageUploader: ImageUploadable {
    private init () {}
    public static let shared = ImageUploader()
}
// MARK: - Method
extension ImageUploader {
    public func uploadImage(image: UIImage, completion: @escaping ImageUrlStringCompletion) {
        guard let jpegData = image.jpegData(compressionQuality: 0.7) else {
            return
        }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_photos/\(fileName)")
        ref.putData(jpegData, metadata: nil) { _, error in
            if let error = error {
                completion(.failure(error))
            }
            ref.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                }
                guard let imageUrl = url?.absoluteString else {
                    return
                }
                completion(.success(imageUrl))
            }
        }
    }
}
