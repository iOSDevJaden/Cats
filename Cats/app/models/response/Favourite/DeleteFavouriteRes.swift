//
//  DeleteFavouriteRes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/22.
//

import Foundation

struct DeleteFavouriteRes: Codable {
    let message: String
    
#if DEBUG
    static let staticDeleteFavouriteRes = DeleteFavouriteRes(
        message: "SUCCESS")
#endif
}
