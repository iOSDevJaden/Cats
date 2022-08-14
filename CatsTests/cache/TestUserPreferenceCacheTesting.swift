//
//  TestUserPreferenceCacheTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/14.
//

import XCTest
@testable import Cats

class TestUserPreferenceCacheTesting: XCTestCase {

    private let userPreferences = UserPreferences.shared

    override func setUp() {
        userPreferences.resetUserSettings()
    }
    
    func test_getUserProfileImage_returns_image_data() {
        let expected = "cat-paw".data(using: .utf8)!
        
        let userProfileImageData = userPreferences.getUserProfileImage()
        XCTAssertEqual(userProfileImageData, expected)
    }
    
    func test_setUserProfileImage_returns_expected_value() {
        let expected = "new-cat-paw-image".data(using: .utf8)
        
        userPreferences.setUserProfileImage(imageData: "new-cat-paw-image".data(using: .utf8))
        
        let userProfileImageData = userPreferences.getUserProfileImage()
        XCTAssertEqual(userProfileImageData, expected)
    }
    
    func test_getUserProfileId_returns_expected_value() {
        let expected = "User Default Id"
        
        let userProfileId = userPreferences.getUserProfileId()
        XCTAssertEqual(userProfileId, expected)
    }
    
    func test_setUserProfileId_returns_expected_value() {
        let expected = "New User Default Id"
        
        userPreferences.setUserProfileId(profileId: "New User Default Id")
        
        let userProfileId = userPreferences.getUserProfileId()
        XCTAssertEqual(userProfileId, expected)
    }
    
    func test_getCurrentSearchImagePage_returns_expected_value() {
        let expected = 0
        
        let userCurrentPage = userPreferences.getCurrentSearchImagePage()
        
        XCTAssertEqual(userCurrentPage, expected)
    }
    
    func test_setCurrentSearchImagePage_returns_increased_value() {
        var expected = 0
        for _ in (0 ..< Int.random(in: 0...50)) {
            expected += 1
            userPreferences.setCurrentSearchImagePage(expected)
        }
        
        let userCurrentPage = userPreferences.getCurrentSearchImagePage()
        XCTAssertEqual(userCurrentPage, expected)
    }
    
    func test_setCurrentSearchImagePage_returns_expected_value() {
        let expected = 40
        
        userPreferences.setCurrentSearchImagePage(40)
        
        let userCurrentPage = userPreferences.getCurrentSearchImagePage()
        XCTAssertEqual(userCurrentPage, expected)
    }
    
    func test_getCurrentNumberOfImagePerPage_returns_default_value() {
        let expected = 15
        
        let numberOfImage = userPreferences.getCurrentNumberOfImagePerPage()
        XCTAssertEqual(numberOfImage, expected)
    }
    
    func test_setCurrentNumberOfImagePerPage_returns_default_value() {
        let expected = 50
        
        userPreferences.setCurrentNumberOfImagePerPage(50)
        
        let numberOfImage = userPreferences.getCurrentNumberOfImagePerPage()
        XCTAssertEqual(numberOfImage, expected)
    }
}
