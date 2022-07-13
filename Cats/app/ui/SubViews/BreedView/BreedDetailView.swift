//
//  BreedDetailView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/13.
//

import SwiftUI

struct BreedDetailView: View {
    let breed: Breed
    
    var body: some View {
        VStack {
            Text(breed.id)
            Text(breed.name)
            Text("\(breed.dogFriendly ?? -1)")
        }
    }
}


struct BreedDetailView_Previews: PreviewProvider {
    static let breed = Breed(id: "", name: "", temperament: "", lifeSpan: "", altName: "", wikipediaUrl: "", origin: "", weightImperial: "", experimental: -1, hairless: -1, natural: -1, rare: -1, rex: -1, suppressTail: -1, shortsLegs: -1, hypoallergenic: -1, adaptability: -1, affectionLevel: -1, countryCode: "", childFriendly: -1, dogFriendly: -1, energyLevel: -1, grooming: -1, healthIssue: -1, intelligence: -1, sheddingLevel: -1, socialNeeds: -1, strangerFriendly: -1, vocalisation: -1)
    static var previews: some View {
        BreedDetailView(breed: breed)
    }
}
