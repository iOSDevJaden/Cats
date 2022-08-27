//
//  TestSearchImageViewModelTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/27.
//

import XCTest
@testable import Cats

class TestSearchImageViewModelTesting: XCTestCase {
    private var mockFavouriteService: FavouriteServiceProtocol!
    private var mockImageService: ImageServiceProtocol!
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
    
}
