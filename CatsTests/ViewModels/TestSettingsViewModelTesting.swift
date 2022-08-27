//
//  TestSettingsViewModelTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/27.
//

import XCTest
@testable import Cats

class TestSettingsViewModelTesting: XCTestCase {
    private var userPreferences: UserPreferences!
    private var viewModel: SettingsViewModel!
    
    override func setUp() {
        userPreferences = UserPreferences.shared
        viewModel = SettingsViewModel(
            userPreference: userPreferences
        )
    }
    
    override func tearDown() {
        resetUserProfiles()
        userPreferences = nil
        viewModel = nil
    }
    
    private func resetUserProfiles() {
        userPreferences.resetUserProfileId(key: KeysForTest.userDefaultProfileIdKeyForTest)
        userPreferences.resetUserProfileImage(key: KeysForTest.userDefaultProfileImageKeyForTest)
        userPreferences.resetCurrentNumberOfImagePerPage(key: KeysForTest.userDefaultCurrentSearchImagePageForTest)
    }
    
    func test_settings_viewModel_load_latest_user_id() {
        viewModel.userId = ""
        
        viewModel.loadUserId(key: KeysForTest.userDefaultProfileIdKeyForTest)
        
        XCTAssertEqual(
            viewModel.userId,
            userPreferences.getUserProfileId(key: KeysForTest.userDefaultProfileIdKeyForTest)
        )
    }
    
    func test_settings_viewModel_load_latest_user_profile_image() {
        viewModel.profileImageData = nil
        
        viewModel.loadUserProfileImage(key: KeysForTest.userDefaultProfileImageKeyForTest)

        XCTAssertEqual(
            viewModel.profileImageData,
            userPreferences.getUserProfileImage(key: KeysForTest.userDefaultProfileImageKeyForTest)
        )
    }
    
    func test_settings_viewModel_load_latest_number_of_image_per_page() {
        viewModel.numberOfImage = 0
        
        viewModel.loadNumberOfImagePerPage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest)

        XCTAssertEqual(
            viewModel.numberOfImage,
            userPreferences.getCurrentNumberOfImagePerPage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest)
        )
    }
    
    func test_settings_viewModel_load_latest_page() {
        viewModel.page = 0
        
        viewModel.loadCurrentPage(key: KeysForTest.userDefaultCurrentSearchImagePageForTest)

        XCTAssertEqual(
            viewModel.page,
            userPreferences.getCurrentSearchImagePage(key: KeysForTest.userDefaultCurrentSearchImagePageForTest)
        )
    }
    
    func test_settings_viewModel_update_number_of_image_per_page() {
        viewModel.loadNumberOfImagePerPage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest)
        
        viewModel.setNumberOfImage(30, key: KeysForTest.userDefaultNumberOfImagePerPageForTest)

        viewModel.loadNumberOfImagePerPage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest)
        XCTAssertEqual(viewModel.numberOfImage, 30)
    }
    
    func test_settings_viewModel_update_number_of_image_per_page_out_of_range_minimum_set_minimum_value() {
        viewModel.loadNumberOfImagePerPage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest)
        
        viewModel.setNumberOfImage(0, key: KeysForTest.userDefaultNumberOfImagePerPageForTest)

        viewModel.loadNumberOfImagePerPage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest)
        XCTAssertEqual(viewModel.numberOfImage, 15)
    }
    
    func test_settings_viewModel_update_number_of_image_per_page_out_of_range_maximum_set_maximum_value() {
        viewModel.loadNumberOfImagePerPage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest)
        
        viewModel.setNumberOfImage(50, key: KeysForTest.userDefaultNumberOfImagePerPageForTest)

        viewModel.loadNumberOfImagePerPage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest)
        XCTAssertEqual(viewModel.numberOfImage, 30)
    }
    
    func test_settings_viewModel_update_user_profile_image() {
        let profileImageData = UIImage(named: "AppIcon")?.jpegData(compressionQuality: 0.5)!
        viewModel.loadUserProfileImage(key: KeysForTest.userDefaultProfileImageKeyForTest)
        
        viewModel.setUserProfileImage(profileImageData, key: KeysForTest.userDefaultProfileImageKeyForTest)
        
        viewModel.loadUserProfileImage(key: KeysForTest.userDefaultProfileImageKeyForTest)
        XCTAssertEqual(viewModel.profileImageData, profileImageData)
    }
    
    func test_settings_viewModel_reset_number_of_image_per_page() {
        viewModel.setNumberOfImage(20, key: KeysForTest.userDefaultNumberOfImagePerPageForTest)

        viewModel.resetNumberOfImage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest)
        
        XCTAssertEqual(viewModel.numberOfImage, 15)
    }
    

    func test_settings_viewModel_reset_user_profile_image() {
        let profileImageData = UIImage(named: "AppIcon")?.jpegData(compressionQuality: 0.5)!
        viewModel.setUserProfileImage(profileImageData, key: KeysForTest.userDefaultProfileImageKeyForTest)
        
        viewModel.resetUserProfileImage(key: KeysForTest.userDefaultProfileImageKeyForTest)
        let defaultProfileImage = UIImage(named: "cat-paw")?.jpegData(compressionQuality: 0.5)!
        
        viewModel.loadUserProfileImage(key: KeysForTest.userDefaultProfileImageKeyForTest)
        XCTAssertEqual(viewModel.profileImageData, defaultProfileImage)
    }
}
