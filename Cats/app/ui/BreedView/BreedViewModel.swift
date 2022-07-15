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
    @Published var categorizedBreeds = Dictionary<String, [Breed]>()
    
    func getAllBreeds() {
        breedService.getBreeds()
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map(\.data)
            .decode(type: [Breed].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { [weak self] breeds in
                // Get Alphabets
                self?.breeds = breeds
                let dictBreeds = Dictionary<String, [Breed]>(
                    grouping: breeds,
                    by: {
                        let name = $0.name
                        let normalizedName = name.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
                        let firstChar = String(normalizedName.first!)
                        return firstChar
                    })
                self?.categorizedBreeds = dictBreeds
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
