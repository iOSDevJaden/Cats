//
//  ImageRes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/21.
//

import Foundation

struct ImageRes: Codable, Identifiable {
    let id: String?
    let url: String?
    let subId: String?
    let createdAt: String?
    let originalFilename: String?
    
    let categories: [CategoryRes]?
    let breeds: [BreedRes]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case subId = "sub_id"
        case createdAt = "created_at"
        case originalFilename = "original_filename"
        case categories = "categories"
        case breeds = "breeds"
    }
}
