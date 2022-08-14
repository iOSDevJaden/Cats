//
//  TestUserPreferenceCacheTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/14.
//

import XCTest

class UserPreferences {
    static let shared = UserPreferences()
    
    private let userDefaults = UserDefaults.standard
    
    private init() { }
    
    func getUserProfileId() -> String {
        let key = UserDefaultKeys.userDefaultProfileIdKey
        guard let userProfileId = userDefaults.string(forKey: key) else {
            return Consts.userDefaultId
        }
        return userProfileId
    }
    
    func setUserProfileId(profileId: String) {
        let key = UserDefaultKeys.userDefaultProfileIdKey
        userDefaults.set(profileId, forKey: key)
    }
    
    // if no data saved ever, returns 0
    func getCurrentSearchImagePage() -> Int {
        let key = UserDefaultKeys.userDefaultCurrentSearchImagePage
        return userDefaults.integer(forKey: key)
    }
    
    func setCurrentSearchImagePage() {
        let key = UserDefaultKeys.userDefaultCurrentSearchImagePage
        let increasedPage = getCurrentSearchImagePage() + 1
        userDefaults.set(increasedPage, forKey: key)
    }
    
    func setCurrentSearchImagePage(_ page: Int) {
        let key = UserDefaultKeys.userDefaultCurrentSearchImagePage
        userDefaults.set(page, forKey: key)
    }
    
    func getCurrentNumberOfImagePerPage() -> Int {
        let key = UserDefaultKeys.userDefaultNumberOfImagePerPage
        return userDefaults.integer(forKey: key)
    }
    
    func setCurrentNumberOfImagePerPage(_ numberOfImage: Int) {
        let key = UserDefaultKeys.userDefaultNumberOfImagePerPage
        userDefaults.set(numberOfImage, forKey: key)
    }
    
    func resetUserSettings() {
        setUserProfileId(profileId: Consts.userDefaultId)
        setCurrentSearchImagePage(Consts.userDefaultCurrentSearchImagePage)
        setCurrentNumberOfImagePerPage(Consts.userDefaultNumberOfImagePerPage)
    }
    
    enum Consts {
        static let userDefaultId = "User Default Id"
        static let userDefaultProfileImage = "cat-paw"
        static let userDefaultNumberOfImagePerPage = 15
        static let userDefaultCurrentSearchImagePage = 0
    }
    
    enum UserDefaultKeys {
        static let userDefaultProfileIdKey = "User Default ID Key"
        static let userDefaultProfileImageKey = "User Default Profile Image Key"
        static let userDefaultNumberOfImagePerPage = "User Default Number Of Image Per Page Key"
        static let userDefaultCurrentSearchImagePage = "User Default Current Search Image Page Key"
    }
}

class TestUserPreferenceCacheTesting: XCTestCase {

    private let userPreferences = UserPreferences.shared

    override func setUp() {
        userPreferences.resetUserSettings()
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
            userPreferences.setCurrentSearchImagePage()
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
