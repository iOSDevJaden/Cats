//
//  TestUserPreferenceCacheTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/14.
//

import XCTest
@testable import Cats

class TestUserPreferenceCacheTesting: XCTestCase {
    
    /**
     * MARK: - 2022.08.27 UserPreference methods shares the same key.
     * Therefore, the test cases affect on the code that actually works.
     */
    private let userPreferences = UserPreferences.shared
   
    override func setUp() {
        resetUserPreferences()
        super.setUp()
    }
    
    private func resetUserPreferences() {
        userPreferences.resetUserProfileId(key: KeysForTest.userDefaultProfileIdKeyForTest)
        userPreferences.resetUserProfileImage(key: KeysForTest.userDefaultProfileImageKeyForTest)
        userPreferences.resetCurrentNumberOfImagePerPage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest)
        userPreferences.resetCurrentSearchImagePage(key: KeysForTest.userDefaultCurrentSearchImagePageForTest)
    }
    
    func test_getUserProfileImage_returns_image_data() {
        let expected = UIImage(named: "cat-paw")?.jpegData(compressionQuality: 0.5)
        
        let userProfileImageData = userPreferences.getUserProfileImage(
            key: KeysForTest.userDefaultProfileImageKeyForTest
        )
        XCTAssertEqual(userProfileImageData, expected)
    }
    
    func test_setUserProfileImage_returns_expected_value() {
        let expected = "new-cat-paw-image".data(using: .utf8)
        
        userPreferences.setUserProfileImage(
            imageData: "new-cat-paw-image".data(using: .utf8),
            key: KeysForTest.userDefaultProfileImageKeyForTest
        )
        
        let userProfileImageData = userPreferences.getUserProfileImage(
            key: KeysForTest.userDefaultProfileImageKeyForTest
        )
        XCTAssertEqual(userProfileImageData, expected)
    }
    
    func test_getUserProfileId_returns_expected_value() {
        let expected = "User Default Id"
        userPreferences.setUserProfileId(
            profileId: expected,
            key: KeysForTest.userDefaultProfileIdKeyForTest
        )
        
        let userProfileId = userPreferences.getUserProfileId(
            key: KeysForTest.userDefaultProfileIdKeyForTest
        )
        XCTAssertEqual(userProfileId, expected)
    }
    
    func test_setUserProfileId_returns_expected_value() {
        let expected = "New User Default Id"
        
        userPreferences.setUserProfileId(
            profileId: "New User Default Id",
            key: KeysForTest.userDefaultProfileIdKeyForTest
        )
        
        let userProfileId = userPreferences.getUserProfileId(
            key: KeysForTest.userDefaultProfileIdKeyForTest
        )
        XCTAssertEqual(userProfileId, expected)
    }
    
    func test_getCurrentSearchImagePage_returns_expected_value() {
        let expected = 0
        
        let userCurrentPage = userPreferences.getCurrentSearchImagePage(
            key: KeysForTest.userDefaultCurrentSearchImagePageForTest
        )
        
        XCTAssertEqual(userCurrentPage, expected)
    }
    
    func test_setCurrentSearchImagePage_returns_increased_value() {
        for page in (0 ... 50) {
            userPreferences.setCurrentSearchImagePage(
                page,
                key: KeysForTest.userDefaultCurrentSearchImagePageForTest
            )
        }
        
        let userCurrentPage = userPreferences.getCurrentSearchImagePage(
            key: KeysForTest.userDefaultCurrentSearchImagePageForTest
        )
        
        let expected = 50
        XCTAssertEqual(userCurrentPage, expected)
        
        userPreferences.setCurrentSearchImagePage(
            0,
            key: KeysForTest.userDefaultCurrentSearchImagePageForTest
        )
    }
    
    func test_setCurrentSearchImagePage_returns_expected_value() {
        let expected = 40
        
        userPreferences.setCurrentSearchImagePage(
            40,
            key: KeysForTest.userDefaultCurrentSearchImagePageForTest
        )
        
        let userCurrentPage = userPreferences.getCurrentSearchImagePage(
            key: KeysForTest.userDefaultCurrentSearchImagePageForTest
        )
        XCTAssertEqual(userCurrentPage, expected)
    }
    
    func test_getCurrentNumberOfImagePerPage_returns_default_value() {
        let expected = 15
        
        let numberOfImage = userPreferences.getCurrentNumberOfImagePerPage(
            key: KeysForTest.userDefaultNumberOfImagePerPageForTest
        )
        XCTAssertEqual(numberOfImage, expected)
    }
    
    func test_setCurrentNumberOfImagePerPage_returns_default_value() {
        let expected = 50
        
        userPreferences.setCurrentNumberOfImagePerPage(
            50,
            key: KeysForTest.userDefaultCurrentSearchImagePageForTest
        )
        
        let numberOfImage = userPreferences.getCurrentNumberOfImagePerPage(
            key: KeysForTest.userDefaultCurrentSearchImagePageForTest
        )
        XCTAssertEqual(numberOfImage, expected)
    }
    
    func test_resetCurrentNumberOfPerPage_returns_default_value() {
        userPreferences.setCurrentNumberOfImagePerPage(25, key: KeysForTest.userDefaultCurrentSearchImagePageForTest)
        
        userPreferences.resetCurrentNumberOfImagePerPage(key: KeysForTest.userDefaultCurrentSearchImagePageForTest)
        
        XCTAssertEqual(15, userPreferences.getCurrentNumberOfImagePerPage(key: KeysForTest.userDefaultCurrentSearchImagePageForTest))
    }
    
    func test_resetCurrentSearchImagePage_returns_default_value() {
        userPreferences.setCurrentSearchImagePage(50, key: KeysForTest.userDefaultNumberOfImagePerPageForTest)
        
        userPreferences.resetCurrentNumberOfImagePerPage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest)
        
        XCTAssertEqual(0, userPreferences.getCurrentSearchImagePage(key: KeysForTest.userDefaultNumberOfImagePerPageForTest))
    }
}
