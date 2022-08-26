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
        userPreferences = nil
        viewModel = nil
    }
    
    
}
