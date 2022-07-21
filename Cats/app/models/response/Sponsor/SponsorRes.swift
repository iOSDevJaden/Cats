//
//  SponsorRes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/22.
//

import Foundation

struct SponsorRes: Codable {
    let name: String
    let description: String
    let url: String
    let logoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case url = "url"
        case logoUrl = "logo_url"
    }
}
