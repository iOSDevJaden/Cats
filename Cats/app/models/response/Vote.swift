//
//  Vote.swift
//  Cats
//
//  Created by 김태호 on 2022/07/09.
//

import Foundation

struct Vote: Codable, Identifiable {
    let value: Int
    let imageId: String
    let subId: String
    let createdAt: String
    let id: String
    let countryCode: String
    
    enum CodingKeys: String, CodingKey {
        case value = "value"
        case imageId = "image_id"
        case subId = "sub_id"
        case createdAt = "created_at"
        case id = "id"
        case countryCode = "country_code"
    }
}
