//
//  MockImageService.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/21.
//

import Combine
import Foundation
@testable import Cats

class MockImageService: ImageServiceProtocol {
    lazy var resultImageModels: AnyPublisher<[ImageModel], Error>! = nil
    lazy var resultImageModel: AnyPublisher<ImageModel, Error>! = nil
    lazy var resultBool: AnyPublisher<Bool, Error>! = nil
    
    func getImage(id imageId: String) -> AnyPublisher<ImageModel, Error> {
        return resultImageModel
    }
    
    func getSingleImage() -> AnyPublisher<ImageModel, Error> {
        return resultImageModel
    }
    
    func getImages(limit: Int, page: Int) -> AnyPublisher<[ImageModel], Error> {
        return resultImageModels
    }
    
    func uploadImage(image: Data) -> AnyPublisher<Bool, Error> {
        return resultBool
    }
}
