//
//  TestHomeViewModelTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/25.
//

import Combine
import XCTest
@testable import Cats

class TestHomeViewModelTesting: XCTestCase {
    private var viewModel: HomeViewModel!
    
    private var mockFavouriteService: MockFavouriteService!
    private var userPreferences: UserPreferences!
    private var cacheManager: CacheManager!
    
    override func setUp() {
        super.setUp()
        mockFavouriteService = MockFavouriteService()
        userPreferences = UserPreferences.shared
        cacheManager = CacheManager.shared
        
        viewModel = HomeViewModel(
            favouriteService: mockFavouriteService,
            userPreferences: userPreferences,
            cacheManager: cacheManager)
    }
    
    override func tearDown() {
        mockFavouriteService = nil
        userPreferences = nil
        cacheManager = nil
        
        viewModel = nil
        
        super.tearDown()
    }
    
    func test_homeViewModel_get_favourite_images_service_success_returns_not_empty_favourites() {
        mockFavouriteService.resultFavourtieModels = Result
            .success([.staticFavouriteModel])
            .publisher
            .eraseToAnyPublisher()
        
        viewModel.getFavouriteImages()
        
        let expectation = XCTestExpectation(description: "Test is set to return empty array.")
        viewModel.$favouriteImages.dropFirst().sink { result in
            expectation.fulfill()
        }
        .store(in: &viewModel.cancellable)
        
        wait(for: [expectation], timeout: 3)
        XCTAssertEqual(viewModel.favouriteImages, [.staticFavouriteModel])
    }
    
    func test_homeViewModel_get_favourite_images_service_success_returns_empty_favourites() {
        mockFavouriteService.resultFavourtieModels = Result
            .success([])
            .publisher
            .eraseToAnyPublisher()
        
        viewModel.getFavouriteImages()
        
        let expectation = XCTestExpectation(description: "Test is set to return empty array.")
        viewModel.$favouriteImages.dropFirst().sink { result in
            expectation.fulfill()
        }
        .store(in: &viewModel.cancellable)
        
        wait(for: [expectation], timeout: 3)
        XCTAssertEqual(viewModel.favouriteImages, [])
    }
    
    func test_homeViewModel_get_favourite_images_service_return_error_replace_with_empty_array() {
        mockFavouriteService.resultFavourtieModels = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        viewModel.getFavouriteImages()
        
        let expectation = XCTestExpectation(description: "Test is set to error")
        viewModel.$favouriteImages.dropFirst().sink { result in
            expectation.fulfill()
        }
        .store(in: &viewModel.cancellable)
        
        wait(for: [expectation], timeout: 3)
        XCTAssertEqual(viewModel.favouriteImages, [])
    }
}
