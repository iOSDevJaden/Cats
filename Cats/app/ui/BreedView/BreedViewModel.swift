//
//  BreedViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation

class BreedViewModel: BaseViewModel, ObservableObject {
    private let breedService: BreedServiceProtocol
    private let diskCache: DiskCache
    private lazy var fileUrl: URL = Const.filePathUrl
    
    @Published var breeds = [BreedModel]()
    
    init(
        breedService: BreedServiceProtocol = BreedService(),
        diskCache: DiskCache = DiskCache.shared
    ) {
        self.breedService = breedService
        self.diskCache = diskCache
    }
    
    func setFilePath(fileUrl: URL) {
        self.fileUrl = fileUrl
    }
    
    func loadBreedModelsIfExists(file: URL = Const.filePathUrl) {
        if diskCache.fileExists(file) {
            loadBreedModelsFromDisk(from: file)
        } else {
            fetchBreedsData(at: file)
        }
    }
    
    func fetchBreedsData(at path: URL) {
        breedService.getBreeds()
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .replaceError(with: [])
            .sink { [weak self] breeds in
                self?.breeds = breeds
                if !breeds.isEmpty {
                    self?.saveBreedsDataOnDisk(breeds: breeds, at: path)
                }
            }
            .store(in: &cancellable)
    }
    
    func loadBreedModelsFromDisk(from path: URL) {
        guard let breedModelData = diskCache.readData(path),
              let breedModels = try? JSONDecoder().decode([BreedModel].self, from: breedModelData)
        else { return }
        self.breeds = breedModels
    }
    
    func convertBreedsToData(breeds: [BreedModel]) -> Data? {
        guard let data = try? JSONEncoder().encode(breeds) else {
            return nil
        }
        return data
    }
    
    func saveBreedsDataOnDisk(breeds: [BreedModel], at path: URL? = nil) {
        let data = convertBreedsToData(breeds: breeds)
        let _ = diskCache.writeData(at: path ?? fileUrl, content: data)
    }
}

extension BreedViewModel {
    private enum Const {
        static var filePathUrl: URL {
            let breedsFilePath = "breeds-models"
            return FileManager.default.temporaryDirectory.appendingPathComponent(breedsFilePath)
        }
    }
}
