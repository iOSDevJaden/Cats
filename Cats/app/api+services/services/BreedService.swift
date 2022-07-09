//
//  BreedService.swift
//  Cats
//
//  Created by 김태호 on 2022/07/09.
//

import Foundation

struct BreedService {
    private var breedApi = BreedApi()
    
    func getBreeds() -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: breedApi.getBreedList())
    }
    
    func getBreeds(by id: String) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: breedApi.getBreedList(id: id))
    }
}
