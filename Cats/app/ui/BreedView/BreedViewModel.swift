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
    
    lazy var userDefault = UserDefaults.standard
    
    @Published var breeds: [BreedRes] = [] {
        didSet { saveBreedsInfo() }
    }
    
    func getAllBreeds() {
        if !getBreedsInfo().isEmpty {
            self.breeds = getBreedsInfo()
            return
        }
        breedService.getBreeds()
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
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
            .replaceError(with: [])
            .sink { [weak self] breeds in
                self?.breeds = breeds
            }
            .store(in: &cancellable)
    }
    
    private func saveBreedsInfo() {
        guard let breedsInfo = try? JSONEncoder().encode(self.breeds) else {
            return
        }
        userDefault.set(breedsInfo, forKey: Const.breedsKey)
    }
    
    private func getBreedsInfo() -> [BreedRes] {
        guard let breeds = userDefault.data(forKey: Const.breedsKey),
              let breedsInfo = try? JSONDecoder().decode([BreedRes].self, from: breeds)
        else {
            return []
        }
        return breedsInfo
    }
}

extension BreedViewModel {
    enum Const {
        static let breedsKey = "breedsKey"
    }
}
