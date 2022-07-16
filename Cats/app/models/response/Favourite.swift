//
//  Favourite.swift
//  Cats
//
//  Created by 김태호 on 2022/07/09.
//

import Foundation

struct Favourite: Codable, Identifiable {
    let id: Int
    let imageId: String?
    let subId: String?
    let createdAt: String?
    let image: Image?

    struct Image: Codable {
        let id: String?
        let url: String?
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageId = "image_id"
        case subId = "sub_id"
        case createdAt = "created_at"
        case image = "image"
    }
}
