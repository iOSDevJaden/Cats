//
//  VoteRes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/21.
//

import Foundation

struct VoteRes: Codable, Identifiable {
    let value: Int
    let imageId: String
    let subId: String?
    let createdAt: String
    let id: Int
    let countryCode: String?
    
    enum CodingKeys: String, CodingKey {
        case value = "value"
        case imageId = "image_id"
        case subId = "sub_id"
        case createdAt = "created_at"
        case id = "id"
        case countryCode = "country_code"
    }
}
