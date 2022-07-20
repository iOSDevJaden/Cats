//
//  FactRes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/21.
//

import Foundation

struct FactRes: Codable, Identifiable {
    let id: String
    let text: String?
    let languageCode: String?
    let breedId: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case text = "text"
        case languageCode = "language_code"
        case breedId = "breed_id"
    }
}
