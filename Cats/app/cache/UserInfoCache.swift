//
//  UserInfoCache.swift
//  Cats
//
//  Created by 김태호 on 2022/07/15.
//

import Foundation
import UIKit

class UserInfoCache: Identifiable {
    static var shared = UserInfoCache()
    
    private init() { }
    
    lazy var id: String = {
        guard let deviceId = UIDevice.current.identifierForVendor?.uuidString else {
            fatalError("Device ID for vendor Error")
        }
        return deviceId
    }()
}
