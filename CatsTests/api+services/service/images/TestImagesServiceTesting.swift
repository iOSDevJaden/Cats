//
//  TestImagesServiceTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/21.
//

import Combine
import XCTest
@testable import Cats

class TestImagesServiceTesting: XCTestCase {
    
    private var mockImageService: MockImageService!
    private var cancellable = Set<AnyCancellable>()
    
    override func setUp() {
        mockImageService = MockImageService()
    }
    
    override func tearDown() {
        mockImageService = nil
    }
    
    // getSingleImage()
    func test_mock_image_service_get_random_single_image_returns_single_image_model() {
        mockImageService.resultImageModel = Result
            .success(ImageModel.staticImageModel)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = ImageModel.staticImageModel
        mockImageService.getSingleImage()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { result in
                    XCTAssertEqual(result, expected)
                })
            .store(in: &cancellable)
    }

    func test_mock_image_service_get_random_single_image_throws_common_response_error() {
        mockImageService.resultImageModel = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = CommonError.response
        mockImageService.getSingleImage()
            .sink(
                receiveCompletion: { result in
                    switch (result) {
                    case .finished: break
                    case .failure(let error):
                        let resultError = error as! CommonError
                        XCTAssertEqual(resultError, expected)
                    }
                },
                receiveValue: { _ in })
            .store(in: &cancellable)
    }
    
    // getImage(id imageId: String)
    func test_mock_image_service_get_image_by_image_id_returns_single_image_model() {
        let imageId = "imageId"
        
        mockImageService.resultImageModel = Result
            .success(ImageModel.staticImageModel)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = ImageModel.staticImageModel
        mockImageService.getImage(id: imageId)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { result in
                    XCTAssertEqual(result, expected)
                })
            .store(in: &cancellable)
    }
    
    func test_mock_image_service_get_image_by_image_id_throws_common_response_error() {
        let imageId = "imageId"
        
        mockImageService.resultImageModel = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = CommonError.response
        mockImageService.getImage(id: imageId)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .finished: break
                    case .failure(let err):
                        let resultError = err as? CommonError
                        XCTAssertEqual(resultError, expected)
                    }
                },
                receiveValue: { _ in })
            .store(in: &cancellable)
    }
    
    // getImages(limit: Int, page: Int)
    func test_mock_image_service_get_images_returns_image_models() {
        let limit = Int.random(in: 0...100),
        page = Int.random(in: 1...200)
        
        mockImageService.resultImageModels = Result
            .success([ImageModel.staticImageModel])
            .publisher
            .eraseToAnyPublisher()
        
        let expected = [ImageModel.staticImageModel]
        mockImageService.getImages(limit: limit, page: page)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { result in
                    XCTAssertEqual(result, expected)
                })
            .store(in: &cancellable)
    }
    
    func test_mock_image_service_get_images_throws_common_response_error() {
        let limit = Int.random(in: 0...100),
        page = Int.random(in: 1...200)
        
        mockImageService.resultImageModels = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = CommonError.response
        mockImageService.getImages(limit: limit, page: page)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .finished: break
                    case .failure(let err):
                        let resultError = err as! CommonError
                        XCTAssertEqual(resultError, expected)
                    }
                },
                receiveValue: { _ in })
            .store(in: &cancellable)
    }
    
    func test_mock_image_service_get_images_throws_common_response_error_replace_with_empty_array() {
        let limit = Int.random(in: 0...100),
        page = Int.random(in: 1...200)
        
        mockImageService.resultImageModels = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected: [ImageModel] = []
        mockImageService.getImages(limit: limit, page: page)
            .replaceError(with: [])
            .sink(
                receiveValue: { result in
                    XCTAssertEqual(result, expected)
                })
            .store(in: &cancellable)
    }
    
    // uploadImage(image: Data)
    func test_mock_image_service_upload_image_returns_true() {
        let imageData = "image_fake_data".data(using: .utf8)!
        
        mockImageService.resultBool = Result
            .success(true)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = true
        mockImageService.uploadImage(image: imageData)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { result in
                    XCTAssertEqual(result, expected)
                })
            .store(in: &cancellable)
    }
    
    func test_mock_image_service_upload_image_returns_false() {
        let imageData = "image_fake_data".data(using: .utf8)!
        
        mockImageService.resultBool = Result
            .success(false)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = false
        mockImageService.uploadImage(image: imageData)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { result in
                    XCTAssertEqual(result, expected)
                })
            .store(in: &cancellable)
    }
    
    func test_mock_image_service_upload_image_throws_common_response_error() {
        let imageData = "image_fake_data".data(using: .utf8)!
        
        mockImageService.resultBool = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = CommonError.response
        mockImageService.uploadImage(image: imageData)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .finished: break
                    case .failure(let err):
                        let resultError = err as! CommonError
                        XCTAssertEqual(resultError, expected)
                    }
                },
                receiveValue: { _ in })
            .store(in: &cancellable)
    }
    
    func test_mock_image_service_upload_image_throws_common_response_error_replace_with_false() {
        let imageData = "image_fake_data".data(using: .utf8)!
        
        mockImageService.resultBool = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = false
        mockImageService.uploadImage(image: imageData)
            .replaceError(with: false)
            .sink(
                receiveValue: { result in
                    XCTAssertEqual(result, expected)
                })
            .store(in: &cancellable)
    }
}
