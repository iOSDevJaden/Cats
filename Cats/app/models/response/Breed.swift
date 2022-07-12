//
//  Breed.swift
//  Cats
//
//  Created by 김태호 on 2022/07/09.
//

import Foundation

struct Breed: Codable, Identifiable {
    let id: String
    let name: String
    let temperament: String?
    let lifeSpan: String?
    let altName: String?
    let wikipediaUrl: String?
    let origin: String?
    let weightImperial: String?
    let experimental: Int?
    let hairless: Int?
    let natural: Int?
    let rare: Int?
    let rex: Int?
    let suppressTail: Int?
    let shortsLegs: Int?
    let hypoallergenic: Int?
    let adaptability: Int?
    let affectionLevel: Int?
    let countryCode: String?
    let childFriendly: Int?
    let dogFriendly: Int?
    let energyLevel: Int?
    let grooming: Int?
    let healthIssue: Int?
    let intelligence: Int?
    let sheddingLevel: Int?
    let socialNeeds: Int?
    let strangerFriendly: Int?
    let vocalisation: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case temperament = "temperament"
        case lifeSpan = "life_span"
        case altName = "alt_name"
        case wikipediaUrl = "wikipedia_url"
        case origin = "origin"
        case weightImperial = "weight_imperial"
        case experimental = "experimental"
        case hairless = "hairless"
        case natural = "natural"
        case rare = "rare"
        case rex = "rex"
        case suppressTail = "suppress_tail"
        case shortsLegs = "shorts_legs"
        case hypoallergenic = "hypoallergenic"
        case adaptability = "adaptability"
        case affectionLevel = "affectionLevel"
        case countryCode = "country_code"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case grooming = "grooming"
        case healthIssue = "health_issue"
        case intelligence = "intelligence"
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case vocalisation = "vocalisation"
    }
}
