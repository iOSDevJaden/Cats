//
//  SourceRes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/22.
//

import Foundation

struct SourceRes: Codable, Identifiable {
    let id: String
    let name: String
    let websiteUrl: String
    let breedId: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case websiteUrl = "website_url"
        case breedId = "breed_id"
    }
}
