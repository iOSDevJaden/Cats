//
//  BreedViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation

class BreedViewModel: ObservableObject {
    private lazy var breedService = BreedService()
    private lazy var cancellable = Set<AnyCancellable>()
    
    private var diskCache = DiskCache.shared
    
    @Published var breeds: [BreedModel] = []
    
    func getBreeds() {
        if checkCacheExists() {
            self.breeds = readData(from: Const.breedsKey)
        } else {
            getAllBreeds()
        }
    }
    
    private func checkCacheExists() -> Bool {
        return diskCache.isNotEmptyPath(at: Const.breedsKey) &&
        diskCache.getDataFromFile(name: Const.breedsKey) != nil
    }
    
    private func getAllBreeds() {
        breedService.getBreeds()
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .replaceError(with: [])
            .sink { [weak self] breeds in
                self?.breeds = breeds
            }
            .store(in: &cancellable)
    }
    
    private func readData(from path: String) -> [BreedModel] {
        guard let data = diskCache.getDataFromFile(name: path),
              let breedRes = try? JSONDecoder().decode([BreedModel].self, from: data)
        else {
            return []
        }
        return breedRes
    }
    
    private func writeData(data: Data) {
        diskCache.setData(data: data, name: Const.breedsKey)
    }
}

extension BreedViewModel {
    enum Const {
        static let breedsKey = "BreedsModels"
    }
}
