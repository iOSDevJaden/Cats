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
    
    private lazy var imageUrl = "https://24.media.tumblr.com/tumblr_m294stk8SQ1qzex9io1_250.jpg"
    
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
    
    func test_search_viewModel_favourite_images_success_returns_true_remove_image_from_image_list() {
        viewModel.images = getFakeImages()
        viewModel.candidateImageUrl = self.imageUrl
        mockFavouriteService.resultBool = Result
            .success(true)
            .publisher
            .eraseToAnyPublisher()

        let expected = XCTestExpectation(description: "Test set to success and return true and remove a image from the list.")
        viewModel.favouriteImage(imageUrl: self.imageUrl)
        
        viewModel.$images.dropFirst().sink { _ in
            expected.fulfill()
        }.store(in: &viewModel.cancellable)
        
        wait(for: [expected], timeout: 3.0)
        XCTAssertEqual(viewModel.images.count, 14)
        XCTAssertEqual(viewModel.candidateImageUrl, nil)
    }
    
    private func getFakeImages(_ count: Int = 15) -> [ImageModel] {
        Array(repeating: ImageModel.staticImageModel, count: count)
    }
}
