//
//  SaveFavouriteRes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/31.
//

import Foundation

struct SaveFavouriteRes: Codable {
    let id: Int
    let message: String
    
    #if DEBUG
    static let staticSaveFavouriteRes =
    SaveFavouriteRes(
        id: 100052981,
        message: "SUCCESS")
    #endif
}
