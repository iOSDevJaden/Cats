//
//  SaveFavouriteRes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/31.
//

import Foundation

struct SaveFavouriteRes: Codable {
    let id: MultipleTypes
    let message: String
    
#if DEBUG
    static let staticSaveFavouriteRes =
    SaveFavouriteRes(
        id: .intValue(100052981),
        message: "SUCCESS")
#endif
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case message = "message"
    }
}
