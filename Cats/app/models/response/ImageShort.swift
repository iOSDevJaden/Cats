//
//  ImageShort.swift
//  Cats
//
//  Created by 김태호 on 2022/07/09.
//

import Foundation

struct ImageShort: Codable, Identifiable {
    let id: String
    let url : String
    let categories: [Category]
    let breeds: [Breed]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case categories = "categories"
        case breeds = "breeds"
    }
}
