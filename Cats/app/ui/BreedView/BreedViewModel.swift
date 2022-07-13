//
//  BreedViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation

class BreedViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    private let breedService = BreedService()
    
    @Published var breeds: [Breed] = []
    
    func getAllBreeds() {
        breedService.getBreeds()
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map(\.data)
            .decode(type: [Breed].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { [weak self] breeds in
                self?.breeds = breeds
            }
            .store(in: &cancellable)
    }
    
    func getBreeds(by id: String) {
        breedService.getBreeds(by: id)
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map(\.data)
            .decode(type: [Breed].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { [weak self] breeds in
                self?.breeds = breeds
            }
            .store(in: &cancellable)
    }
}
