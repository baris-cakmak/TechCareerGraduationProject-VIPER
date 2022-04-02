//
//  ImageUploaderImp.swift
//  TechCareerGraduationProject
//
//  Created by Peace on 30.03.2022.
//

import UIKit.UIImage


protocol ImageUploadable {
    
    typealias imageUrlStringCompletion = (Result<String, Error>) -> Void
    
    func uploadImage(image: UIImage, completion: @escaping imageUrlStringCompletion)
}
