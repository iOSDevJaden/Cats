//
//  TestFavouriteServiceTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/21.
//

import Combine
import XCTest
@testable import Cats

class TestFavouriteServiceTesting: XCTestCase {
    var mockFavouriteService: MockFavouriteService!
    var cancellable = Set<AnyCancellable>()
    
    override func setUp() {
        mockFavouriteService = MockFavouriteService()
    }
    
    override func tearDown() {
        mockFavouriteService = nil
    }
    
    // getMyFavourites()
    func test_favourite_service_get_my_favourites_returns_favourite_models() {
        let expected = [FavouriteModel.staticFavouriteModel]
        
        mockFavouriteService.resultFavourtieModels = Result
            .success([FavouriteModel.staticFavouriteModel])
            .publisher
            .eraseToAnyPublisher()
        
        mockFavouriteService.getMyFavourites()
            .replaceError(with: [])
            .sink(
                receiveValue: { result in
                    XCTAssertEqual(result, expected)
                })
            .store(in: &self.cancellable)
    }
    
    func test_favourite_service_get_my_favourites_throws_common_response_error() {
        mockFavouriteService.resultFavourtieModels = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = CommonError.response
        
        mockFavouriteService.getMyFavourites()
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let err):
                        let resultError = err as! CommonError
                        XCTAssertEqual(expected, resultError)
                    case .finished: print("")
                    }
                },
                receiveValue: { _ in })
            .store(in: &self.cancellable)
    }
    
    // getMyFavourtie(favourite id: String)
    func test_favourite_service_get_my_favourite_by_favourite_id_returns_favourite_model() {
        let favouriteId = "favouriteId"
        
        mockFavouriteService.resultFavourtieModel = Result
            .success(FavouriteModel.staticFavouriteModel)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = FavouriteModel.staticFavouriteModel
        
        mockFavouriteService.getMyFavourtie(favourite: favouriteId)
            .sink(
                receiveCompletion: { _ in},
                receiveValue: { result in
                    XCTAssertEqual(expected, result)
                })
            .store(in: &self.cancellable)
    }
    
    func test_favourite_service_get_my_favourite_by_favourite_id_throws_common_response_error() {
        let favouriteId = "unknown favourite id"
        mockFavouriteService.resultFavourtieModel = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = CommonError.response
        
        mockFavouriteService.getMyFavourtie(favourite: favouriteId)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let err):
                        let resultError = err as! CommonError
                        XCTAssertEqual(expected, resultError)
                    case .finished: print("")
                    }
                },
                receiveValue: { _ in })
            .store(in: &self.cancellable)
    }
    
    // deleteMyFavourite(favourite id: String)
    func test_favourite_service_delete_my_favourite_returns_true() {
        let favouriteId = "favouriteId"
        
        mockFavouriteService.resultBool = Result
            .success(true)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = true
        
        mockFavouriteService.deleteMyFavourite(favourite: favouriteId)
            .replaceError(with: false)
            .sink(
                receiveCompletion: { _ in},
                receiveValue: { result in
                    XCTAssertEqual(expected, result)
                })
            .store(in: &cancellable)
    }
    
    func test_favourite_service_delete_my_favourite_returns_false() {
        let favouriteId = "favouriteId"
        
        mockFavouriteService.resultBool = Result
            .success(false)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = false
        
        mockFavouriteService.deleteMyFavourite(favourite: favouriteId)
            .sink(
                receiveCompletion: { _ in},
                receiveValue: { result in
                    XCTAssertEqual(expected, result)
                })
            .store(in: &cancellable)
    }
    
    func test_favourite_service_delete_my_favourite_throws_common_response_error() {
        let favouriteId = "Unknown favourite Id"
        
        mockFavouriteService.resultBool = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = CommonError.response
        
        mockFavouriteService.deleteMyFavourite(favourite: favouriteId)
            .sink(
                receiveCompletion: { result in
                    switch (result) {
                    case .failure(let err):
                        let resultError = err as! CommonError
                        XCTAssertEqual(resultError, expected)
                    case .finished: break
                    }
                },
                receiveValue: { _ in })
            .store(in: &cancellable)
    }
    
    func test_favourite_service_delete_my_favourite_throws_common_response_error_replace_with_false() {
        let favouriteId = "Unknown favourite Id"
        
        mockFavouriteService.resultBool = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = false
        
        mockFavouriteService.deleteMyFavourite(favourite: favouriteId)
            .replaceError(with: false)
            .sink(
                receiveValue: { result in
                    XCTAssertEqual(result, expected)
                })
            .store(in: &cancellable)
    }
    
    // saveFavouriteImage(id imageId: String)
    func test_favourite_service_save_favourite_image_returns_true() {
        let imageId = "Image Id from Favourite Image"
        
        mockFavouriteService.resultBool = Result
            .success(true)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = true
        
        mockFavouriteService.saveFavouriteImage(id: imageId)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { result in
                    XCTAssertEqual(result, expected)
                })
            .store(in: &cancellable)
    }
    
    func test_favourite_service_save_favourite_image_returns_false() {
        let imageId = "Image Id from Favourite Image"
        
        mockFavouriteService.resultBool = Result
            .success(false)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = false
        
        mockFavouriteService.saveFavouriteImage(id: imageId)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { result in
                    XCTAssertEqual(result, expected)
                })
            .store(in: &cancellable)
    }
    
    func test_favourite_service_save_favourite_image_throws_common_response_error() {
        let imageId = "Unknown Image Id"
        
        mockFavouriteService.resultBool = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = CommonError.response
        
        mockFavouriteService.saveFavouriteImage(id: imageId)
            .sink(
                receiveCompletion: { result in
                    switch (result) {
                    case .failure(let err):
                        let resultError = err as! CommonError
                        XCTAssertEqual(resultError, expected)
                    case .finished: break
                    }
                },
                receiveValue: { _ in })
            .store(in: &cancellable)
    }
    
    func test_favourite_service_save_favourite_image_throws_common_response_error_replace_with_false() {
        let imageId = "Unknown Image Id"
        
        mockFavouriteService.resultBool = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = false
        
        mockFavouriteService.saveFavouriteImage(id: imageId)
            .replaceError(with: false)
            .sink(
                receiveValue: { result in
                    XCTAssertEqual(result, expected)
                })
            .store(in: &cancellable)
    }
}
