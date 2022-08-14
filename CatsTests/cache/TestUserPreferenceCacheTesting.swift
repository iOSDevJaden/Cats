//
//  TestUserPreferenceCacheTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/14.
//

import XCTest
@testable import Cats

class UserPreferences {
    static let shared = UserPreferences()
    
    private let userDefaults = UserDefaults.standard
    
    private init() { }
    
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
    
    func resetUserSettings() {
        setCurrentSearchImagePage(Consts.userDefaultCurrentSearchImagePage)
    }
    
    enum Consts {
        static let userDefaultCurrentSearchImagePage = 0
    }
    
    enum UserDefaultKeys {
        static let userDefaultCurrentSearchImagePage = "User Default Current Search Image Page Key"
    }
}

class TestUserPreferenceCacheTesting: XCTestCase {

    private let userPreferences = UserPreferences.shared

    override func setUp() {
        userPreferences.resetUserSettings()
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
}
