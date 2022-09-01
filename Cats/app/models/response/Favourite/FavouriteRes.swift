//
//  FavouriteRes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/21.
//

import Foundation

struct FavouriteRes: Codable, Identifiable {
    let id: Int
    let imageId: String?
    let subId: String?
    let createdAt: String?
    let image: ImageModel

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageId = "image_id"
        case subId = "sub_id"
        case createdAt = "created_at"
        case image = "image"
    }
    
    func mapToFavouriteModel() -> FavouriteModel {
        return FavouriteModel(favouriteId: "\(id)", imageModel: image)
    }
#if DEBUG
    static let staticFavouriteRes = FavouriteRes(
        id: 100052852,
        imageId: "2gh",
        subId: "user default id",
        createdAt: "2022-07-30T21:54:58.000Z",
        image: .staticImageModel)
#endif
}
