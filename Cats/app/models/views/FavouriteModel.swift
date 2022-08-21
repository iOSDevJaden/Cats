//
//  FavouriteModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/31.
//

import Foundation

struct FavouriteModel: Equatable {
    let favouriteId: String
    let imageModel: ImageModel
    
#if DEBUG
    static let staticFavouriteModel = FavouriteModel(favouriteId: "favouriteId", imageModel: .staticImageModel)
#endif
}
