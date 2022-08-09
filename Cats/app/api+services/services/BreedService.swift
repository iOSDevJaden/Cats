//
//  BreedService.swift
//  Cats
//
//  Created by 김태호 on 2022/07/09.
//

import Combine
import Foundation

protocol BreedServiceProtocol {
    func getBreeds() -> AnyPublisher<[BreedModel], Error>
    func getBreeds(by id: String) -> AnyPublisher<[BreedModel], Error>
}

class BreedService: BaseService, BreedServiceProtocol {
    
    func getBreeds() -> AnyPublisher<[BreedModel], Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: BreedApi().getBreedList())
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .map(\.data)
                    .decode(type: [BreedRes].self, decoder: JSONDecoder())
                    .map { breedRes in
                        var breedModels: [BreedModel] = []
                        breedRes.forEach {
                            breedModels.append($0.mapToBreedModel())
                        }
                        return breedModels
                    }
                    .sink(
                        receiveCompletion: {
                            switch($0) {
                            case .failure(let error):
                                promise(.failure(error))
                            case .finished: return
                            }
                        },
                        receiveValue: {
                            promise(.success($0))
                        })
                    .store(in: &self.cancellable)
            }
        }
        .eraseToAnyPublisher()
    }
    
    
    func getBreeds(by id: String) -> AnyPublisher<[BreedModel], Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: BreedApi().getBreedList(id: id))
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .map(\.data)
                    .decode(type: [BreedRes].self, decoder: JSONDecoder())
                    .map { breedRes in
                        var breedModels: [BreedModel] = []
                        breedRes.forEach {
                            breedModels.append($0.mapToBreedModel())
                        }
                        return breedModels
                    }
                    .sink(
                        receiveCompletion: {
                            switch($0) {
                            case .failure(let error):
                                promise(.failure(error))
                            case .finished: return
                            }
                        },
                        receiveValue: {
                            promise(.success($0))
                        })
                    .store(in: &self.cancellable)
            }
        }.eraseToAnyPublisher()
    }
}
