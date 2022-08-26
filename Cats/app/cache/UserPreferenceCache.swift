//
//  UserPreferenceCache.swift
//  Cats
//
//  Created by 김태호 on 2022/08/14.
//

import Foundation

class UserPreferences {
    static let shared = UserPreferences()
    
    private let userDefaults = UserDefaults.standard
    
    private init() { }
    
    func getUserProfileImage() -> Data {
        let key = UserDefaultKeys.userDefaultProfileImageKey
        guard let profileImageData = userDefaults.data(forKey: key) else {
            return Consts.userDefaultProfileImage
        }
        return profileImageData
    }
    
    func setUserProfileImage(imageData: Data?) {
        let key = UserDefaultKeys.userDefaultProfileImageKey
        userDefaults.set(imageData, forKey: key)
    }
    
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
    
    // MARK: - Making increased page value inside the function removed since it reflects business logic.
    /* func setCurrentSearchImagePage() {
        let key = UserDefaultKeys.userDefaultCurrentSearchImagePage
        let increasedPage = getCurrentSearchImagePage() + 1
        userDefaults.set(increasedPage, forKey: key)
    } */
    
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
        setUserProfileImage(imageData: Consts.userDefaultProfileImage)
        setCurrentSearchImagePage(Consts.userDefaultCurrentSearchImagePage)
        setCurrentNumberOfImagePerPage(Consts.userDefaultNumberOfImagePerPage)
    }
    
    enum Consts {
        static let userDefaultId = String.userId
        static let userDefaultProfileImage = Data.placeHolderImageData
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

