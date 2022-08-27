//
//  TestSearchImageViewModelTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/27.
//

import XCTest
@testable import Cats

class TestSearchImageViewModelTesting: XCTestCase {
    private var mockFavouriteService: MockFavouriteService!
    private var mockImageService: MockImageService!
    private var userPreferences: UserPreferences!
    
    private var viewModel: SearchViewModel!
    
    override func setUp() {
        self.mockFavouriteService = MockFavouriteService()
        self.mockImageService = MockImageService()
        self.userPreferences = UserPreferences.shared
        
        self.viewModel = SearchViewModel(
            favouriteService: mockFavouriteService,
            imagesService: mockImageService,
            userPreferences: userPreferences
        )
    }
    
    override func tearDown() {
        userPreferences.resetCurrentSearchImagePage(key: KeysForTest.userDefaultCurrentSearchImagePageForTest)
        userPreferences.resetCurrentNumberOfImagePerPage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest)
        
        self.mockFavouriteService = nil
        self.mockImageService = nil
        self.userPreferences = nil
        
        self.viewModel = nil
    }
    
    func test_search_viewModel_update_page_and_load_latest_page() {
        viewModel.loadCurrentPage(key: KeysForTest.userDefaultCurrentSearchImagePageForTest)
        let initialPage = viewModel.page
        
        viewModel.updateCurrentPage(key: KeysForTest.userDefaultCurrentSearchImagePageForTest)
        
        viewModel.loadCurrentPage(key: KeysForTest.userDefaultCurrentSearchImagePageForTest)
        XCTAssertEqual(initialPage + 1, viewModel.page)
    }
    
    func test_search_viewModel_get_images_success_returns_15_images_and_append_to_member_variable() {
        let numberOfImage = userPreferences.getCurrentNumberOfImagePerPage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest)
        mockImageService.resultImageModels = Result
            .success(getFakeImages(numberOfImage))
            .publisher
            .eraseToAnyPublisher()
        
        let expected = XCTestExpectation(description: "Test set to success and return 15 image models.")
        viewModel.getImages()
        
        viewModel.$images.dropFirst().sink { result in
            expected.fulfill()
        }
        .store(in: &viewModel.cancellable)
        
        wait(for: [expected], timeout: 3.0)
        XCTAssertEqual(viewModel.images.count, numberOfImage)
    }
    
    func test_search_viewModel_get_images_failed_returns_empty_array_of_image_model() {
        mockImageService.resultImageModels = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = XCTestExpectation(description: "Test set to fail and return 0 image model.")
        viewModel.getImages()
        
        viewModel.$images.dropFirst().sink { result in
            expected.fulfill()
        }
        .store(in: &viewModel.cancellable)
        
        wait(for: [expected], timeout: 3.0)
        XCTAssertEqual(viewModel.images.isEmpty, true)
    }
    
    func test_search_viewModel_favourite_images_success_returns_true() {
        mockFavouriteService.resultBool = Result
            .success(true)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = XCTestExpectation(description: "Test set to success and return true.")
        viewModel.favouriteImage(imageId: "favourite #1")
        
        viewModel.$favouritedImage.dropFirst().sink { result in
            expected.fulfill()
        }
        .store(in: &viewModel.cancellable)
        
        wait(for: [expected], timeout: 3.0)
        XCTAssertEqual(viewModel.favouritedImage, true)
    }
    
    func test_search_viewModel_favourite_images_success_returns_false() {
        mockFavouriteService.resultBool = Result
            .success(false)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = XCTestExpectation(description: "Test set to success and return false.")
        viewModel.favouriteImage(imageId: "favourite #1")
        
        viewModel.$favouritedImage.dropFirst().sink { result in
            expected.fulfill()
        }
        .store(in: &viewModel.cancellable)
        
        wait(for: [expected], timeout: 3.0)
        XCTAssertEqual(viewModel.favouritedImage, false)
    }
    
    func test_search_viewModel_favourite_images_failed_return_error_replace_with_false() {
        mockFavouriteService.resultBool = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        let expected = XCTestExpectation(description: "Test set to fail and return false.")
        viewModel.favouriteImage(imageId: "favourite #1")
        
        viewModel.$favouritedImage.dropFirst().sink { result in
            expected.fulfill()
        }
        .store(in: &viewModel.cancellable)
        
        wait(for: [expected], timeout: 3.0)
        XCTAssertEqual(viewModel.favouritedImage, false)
    }
    
    private func getFakeImages(_ count: Int = 15) -> [ImageModel] {
        Array(repeating: ImageModel.staticImageModel, count: count)
    }
}
