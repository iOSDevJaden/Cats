//
//  SettingsViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/25.
//

import Foundation

class SettingsViewModel: ObservableObject {
    private let userPreference = UserPreferences.shared
    
    func getUserId() -> String {
        return userPreference.getUserProfileId()
    }
    
    // Current Page
    func getCurrentPage() -> Int {
        return userPreference.getCurrentSearchImagePage()
    }
    
    func setCurrentPage(_ page: Int) {
        userPreference.setCurrentSearchImagePage(page)
    }
    
    func getNumberOfImage() -> Int {
        return userPreference.getCurrentNumberOfImagePerPage()
    }
    
    func setNumberOfImage(_ numberOfImage: Int) {
        userPreference.setCurrentNumberOfImagePerPage(numberOfImage)
    }
}
