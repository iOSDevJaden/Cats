//
//  VoteRequest.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Foundation

struct VoteRequest: Codable {
    let imageId: String
    let subId: String
    let value: Int
    
    enum CodingKeys: String, CodingKey {
        case imageId = "image_id"
        case subId = "sub_id"
        case value = "value"
    }
}
