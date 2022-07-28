//
//  UserInfoCache.swift
//  Cats
//
//  Created by 김태호 on 2022/07/15.
//

import Foundation
import UIKit

/**
 * User Info and User Preference Properties.
 * `MARK: - UIKit imported to get vendor id which is unique and never change.`
 * `However when you remove and re-install this app, it could change.`*/

class UserInfoCache: Identifiable {
    static var shared = UserInfoCache()
    lazy var userDefault = UserDefaults.standard
    
    private init() { }
    
    lazy var id: String = {
        guard let deviceId = UIDevice.current.identifierForVendor?.uuidString else {
            fatalError("Device ID for vendor Error")
        }
        return deviceId
    }()
    
    // Current Page
    func getCurrentPage() -> Int {
        if let currentImagePage = userDefault.value(forKey: Const.currentImagePageKey) as? Int {
            return currentImagePage
        }
        return Const.defualtNumberOfImage
    }
    
    func setCurrentPage(page: Int) {
        userDefault.set(page, forKey: Const.currentImagePageKey)
    }
    
    // Furthest Page
    func getMaximumPage() -> Int {
        if let lastImagePage = userDefault.value(forKey: Const.lastImagePageKey) as? Int {
            return lastImagePage
        }
        return Const.defualtMaximumPage
    }
    
    func updateMaximumPage(page: Int) {
        userDefault.set(page, forKey: Const.lastImagePageKey)
    }
    
    // Number of cat pictures in the page
    // Home and Search View
    func getNumberOfImage() -> Int {
        if let numberOfImage = userDefault.value(forKey: Const.numberOfImage) as? Int {
            return numberOfImage
        }
        return Const.defualtNumberOfImage
    }
    
    func setNumberOfImage(_ number: Int) {
        userDefault.set(number, forKey: Const.numberOfImage)
    }
}

extension UserInfoCache {
    enum Const {
        static let defualtNumberOfImage = 15
        static let defualtMaximumPage = 0
        static let defualtCurrentImagePage = 0
        static let lastImagePageKey = "LastImagePageKey"
        static let currentImagePageKey = "CurrentImagePageKey"
        static let numberOfImage = "NumberOfImage"
    }
}
