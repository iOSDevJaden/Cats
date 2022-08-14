//
//  BreedViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation

class BreedViewModel: BaseViewModel, ObservableObject {
    private lazy var breedService = BreedService()
    private let diskCache = DiskCache.shared
    
    @Published var breeds: [BreedModel] = []
    
    func getBreedsData() {
        if cacheFileExists() {
            setBreedsModels()
        } else {
            fetchBreedsData()
        }
    }
    
    private func fetchBreedsData() {
        breedService.getBreeds()
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .replaceError(with: [])
            .sink { [weak self] breeds in
                self?.breeds = breeds
                self?.saveBreedModelsDataCache(breeds)
            }
            .store(in: &cancellable)
    }
    
    private func cacheFileExists() -> Bool {
        return diskCache.fileExists(Const.filePathUrl)
    }
    
    private func getCacheFileData() -> Data? {
        return diskCache.readData(Const.filePathUrl)
    }
    
    private func setBreedsModels() {
        guard
            let breedsData = getCacheFileData(),
            let breedModels = try? JSONDecoder().decode([BreedModel].self, from: breedsData)
        else { return }
        self.breeds = breedModels
    }
    
    @discardableResult
    private func saveBreedModelsDataCache(_ breeds: [BreedModel]) -> Bool {
        guard
            let breedsData = try? JSONEncoder().encode(breeds)
        else {
            return false
        }
        return diskCache.writeData(at: Const.filePathUrl, content: breedsData)
    }
}

extension BreedViewModel {
    private enum Const {
        static var filePathUrl: URL {
            let breedsKey = "breeds-models"
            return FileManager.default.temporaryDirectory.appendingPathComponent(breedsKey)
        }
    }
}
