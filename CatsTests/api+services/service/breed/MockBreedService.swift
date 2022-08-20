//
//  MockBreedService.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/15.
//

import Combine
import Foundation
@testable import Cats

class MockBreedsService: BreedServiceProtocol {
    var result: AnyPublisher<[BreedModel], Error>!
    
    func getBreeds() -> AnyPublisher<[BreedModel], Error> {
        return result
    }
    
    func getBreeds(by id: String) -> AnyPublisher<[BreedModel], Error> {
        return result
    }
}
