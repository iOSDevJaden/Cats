//
//  BreedModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/21.
//

import Foundation

struct BreedModel: Codable, Identifiable {
    let id: String
    let breedName: String
    let wikipediaUrl: String
    let breedTemperament: String
    let breedOrigin: String
    
    let childFriendly: Int
    let dogFriendly: Int
    let energyLevel: Int
    let strangerFriendly: Int
    let socialNeeds: Int
}
