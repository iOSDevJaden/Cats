//
//  SettingsViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/25.
//

import Foundation

class SettingsViewModel: ObservableObject {
    private let userInfoCahce = UserInfoCache.shared
    
    @Published var numberOfPicture = 15
    
    func getUserId() -> String {
        return userInfoCahce.id
    }
    
    // Current Page
    func getCurrentPage() -> Int {
        return userInfoCahce.getCurrentPage()
    }
    
    func setCurrentPage(_ page: Int) {
        userInfoCahce.setCurrentPage(page: page)
    }
    
    // Maximum Page
    // Will be deprecated.
    func getMaximumPage() -> Float {
        return Float(userInfoCahce.getMaximumPage())
    }
    
    func getNumberOfImage() -> Int {
        return userInfoCahce.getNumberOfImage()
    }
    
    func setNumberOfImage(_ page: Int) {
        userInfoCahce.setNumberOfImage(page)
    }
}
