//
//  SettingsViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/25.
//

import Foundation

class SettingsViewModel: BaseViewModel, ObservableObject {
    private let userPreference: UserPreferences
    
    @Published var userId = ""
    @Published var profileImageData: Data? = nil
    @Published var page = 0
    @Published var numberOfImage = 0
    
    init(
        userPreference: UserPreferences = UserPreferences.shared
    ) {
        self.userPreference = userPreference
    }
    
    func loadUserId(key: String? = nil) {
        self.userId = getUserId(key: key)
    }
    
    func loadUserProfileImage(key: String? = nil) {
        self.profileImageData = getUserProfileImage(key: key)
    }
    
    func loadCurrentPage(key: String? = nil) {
        self.page = getCurrentPage(key: key)
    }
    
    func loadNumberOfImagePerPage(key: String? = nil) {
        self.numberOfImage = getNumberOfImage(key: key)
    }
    
    func getUserId(key: String? = nil) -> String {
        if let key = key {
            return userPreference.getUserProfileId(key: key)
        }
        return userPreference.getUserProfileId()
    }
    
    // Current Page
    func getCurrentPage(key: String? = nil) -> Int {
        if let key = key {
            return userPreference.getCurrentSearchImagePage(key: key)
        }
        return userPreference.getCurrentSearchImagePage()
    }
    
    func setCurrentPage(
        _ page: Int,
        key: String? = nil
    ) {
        if let key = key {
            userPreference.setCurrentSearchImagePage(
                page,
                key: key
            )
        }
        userPreference.setCurrentSearchImagePage(page)
    }
    
    func getNumberOfImage(key: String? = nil) -> Int {
        if let key = key {
            return userPreference.getCurrentNumberOfImagePerPage(key: key)
        }
        return userPreference.getCurrentNumberOfImagePerPage()
    }
    
    func setNumberOfImage(
        _ numberOfImage: Int,
        key: String? = nil
    ) {
        if let key = key {
            userPreference.setCurrentNumberOfImagePerPage(numberOfImage, key: key)
        }
        userPreference.setCurrentNumberOfImagePerPage(numberOfImage)
    }
    
    func getUserProfileImage(key: String? = nil) -> Data {
        if let key = key {
            return userPreference.getUserProfileImage(key: key)
        }
        return userPreference.getUserProfileImage()
    }
    
    func setUserProfileImage(
        _ imageData: Data?,
        key: String? = nil
    )  {
        if let key = key {
            userPreference.setUserProfileImage(imageData: imageData, key: key)
        }
        userPreference.setUserProfileImage(imageData: imageData)
    }
}
