//
//  BreedService.swift
//  Cats
//
//  Created by 김태호 on 2022/07/09.
//

import Combine
import Foundation

class BreedService {
    private var cancellable = Set<AnyCancellable>()
    private var breedApi = BreedApi()
    
    func getBreeds() -> AnyPublisher<[BreedRes], Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: self.breedApi.getBreedList())
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .map(\.data)
                    .decode(type: [BreedRes].self, decoder: JSONDecoder())
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
    
    
    func getBreeds(by id: String) -> AnyPublisher<[BreedRes], Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: self.breedApi.getBreedList(id: id))
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .map(\.data)
                    .decode(type: [BreedRes].self, decoder: JSONDecoder())
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
