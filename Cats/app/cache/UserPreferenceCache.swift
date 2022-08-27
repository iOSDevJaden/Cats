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
    
    func getUserProfileImage(
        key: String = UserDefaultKeys.userDefaultProfileImageKey
    ) -> Data {
        userDefaults.data(forKey: key) ?? Consts.userDefaultProfileImage
    }
    
    func setUserProfileImage(
        imageData: Data?,
        key: String = UserDefaultKeys.userDefaultProfileImageKey
    ) {
        userDefaults.set(imageData, forKey: key)
    }
    
    func resetUserProfileImage(
        key: String = UserDefaultKeys.userDefaultProfileImageKey
    ) {
        userDefaults.set(Consts.userDefaultProfileImage, forKey: key)
    }
    
    func getUserProfileId(
        key: String = UserDefaultKeys.userDefaultProfileIdKey
    ) -> String {
        userDefaults.string(forKey: key) ?? Consts.userDefaultId
    }
    
    func setUserProfileId(
        profileId: String,
        key: String = UserDefaultKeys.userDefaultProfileIdKey
    ) {
        userDefaults.set(profileId, forKey: key)
    }
    
    func resetUserProfileId(
        key: String = UserDefaultKeys.userDefaultProfileIdKey
    ) {
        userDefaults.set(Consts.userDefaultId, forKey: key)
    }
    
    // if no data saved ever, returns 0
    func getCurrentSearchImagePage(
        key: String = UserDefaultKeys.userDefaultCurrentSearchImagePage
    ) -> Int {
        userDefaults.integer(forKey: key)
    }
    
    // MARK: - Making increased page value inside the function removed since it reflects business logic.
    /* func setCurrentSearchImagePage() {
     let key = UserDefaultKeys.userDefaultCurrentSearchImagePage
     let increasedPage = getCurrentSearchImagePage() + 1
     userDefaults.set(increasedPage, forKey: key)
     } */
    
    func setCurrentSearchImagePage(
        _ page: Int,
        key: String = UserDefaultKeys.userDefaultCurrentSearchImagePage
    ) {
        userDefaults.set(page, forKey: key)
    }
    
    func resetCurrentSearchImagePage(
        key: String = UserDefaultKeys.userDefaultCurrentSearchImagePage
    ) {
        userDefaults.set(
            Consts.userDefaultCurrentSearchImagePage,
            forKey: key
        )
    }
    
    func getCurrentNumberOfImagePerPage(
        key: String = UserDefaultKeys.userDefaultNumberOfImagePerPage
    ) -> Int {
        userDefaults.integer(forKey: key) == 0 ?
        Consts.userDefaultNumberOfImagePerPage : userDefaults.integer(forKey: key)
    }
    
    func setCurrentNumberOfImagePerPage(
        _ numberOfImage: Int,
        key: String = UserDefaultKeys.userDefaultNumberOfImagePerPage
    ) {
        userDefaults.set(numberOfImage, forKey: key)
    }
    
    func resetCurrentNumberOfImagePerPage(
        key: String = UserDefaultKeys.userDefaultNumberOfImagePerPage
    ) {
        userDefaults.set(
            Consts.userDefaultCurrentSearchImagePage,
            forKey: key
        )
    }
    
    func resetUserSettings() {
        resetUserProfileId()
        resetUserProfileImage()
        resetCurrentNumberOfImagePerPage()
    }
    
    fileprivate enum Consts {
        static let userDefaultId = String.userId
        static let userDefaultProfileImage = Data.placeHolderImageData
        static let userDefaultNumberOfImagePerPage = 15
        static let userDefaultCurrentSearchImagePage = 0
    }
    
    fileprivate enum UserDefaultKeys {
        static let userDefaultProfileIdKey = "User Default ID Key"
        static let userDefaultProfileImageKey = "User Default Profile Image Key"
        static let userDefaultNumberOfImagePerPage = "User Default Number Of Image Per Page Key"
        static let userDefaultCurrentSearchImagePage = "User Default Current Search Image Page Key"
    }
}
