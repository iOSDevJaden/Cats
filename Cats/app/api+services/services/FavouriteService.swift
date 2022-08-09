//
//  FavouriteService.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation

protocol FavouriteServiceProtocol {
    func getMyFavourites() -> AnyPublisher<[FavouriteModel], Error>
    func getMyFavourtie(favourite id: String) -> AnyPublisher<FavouriteModel, Error>
    func deleteMyFavourite(favourite id: String) -> AnyPublisher<Bool, Error>
    func saveFavouriteImage(id imageId: String) -> AnyPublisher<Bool, Error>
}

class FavouriteService: BaseService, FavouriteServiceProtocol {
    
    func getMyFavourites() -> AnyPublisher<[FavouriteModel], Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: FavouriteApi().getMyFavourites())
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .receive(on: DispatchQueue.main)
                    .map(\.data)
                    .decode(type: [FavouriteRes].self, decoder: JSONDecoder())
                    .map { favouriteRes in
                        var favouriteModels: [FavouriteModel] = []
                        favouriteRes.forEach {
                            favouriteModels.append($0.mapToFavouriteModel())
                        }
                        return favouriteModels
                    }
                    .sink(
                        receiveCompletion: {
                            switch $0 {
                            case .failure(let error):
                                promise(.failure(error))
                            case .finished:
                                return
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
    
    func getMyFavourtie(favourite id: String) -> AnyPublisher<FavouriteModel, Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: FavouriteApi().getMyFavourites())
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .receive(on: DispatchQueue.main)
                    .map(\.data)
                    .decode(type: FavouriteRes.self, decoder: JSONDecoder())
                    .map { $0.mapToFavouriteModel()}
                    .sink(
                        receiveCompletion: {
                            switch $0 {
                            case .failure(let error):
                                promise(.failure(error))
                            case .finished:
                                return
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
    
    func deleteMyFavourite(favourite id: String) -> AnyPublisher<Bool, Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: FavouriteApi().deleteFavourite(favourite: id))
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .receive(on: DispatchQueue.main)
                    .map(\.data)
                    .decode(type: DeleteVoteRes.self, decoder: JSONDecoder())
                    .sink(
                        receiveCompletion: {
                            switch $0 {
                            case .failure(let error):
                                promise(.failure(error))
                            case .finished:
                                return
                            }
                        },
                        receiveValue: {
                            promise(.success($0.message == ServiceConst.success))
                        })
                    .store(in: &self.cancellable)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func saveFavouriteImage(id imageId: String) -> AnyPublisher<Bool, Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(
                    for: FavouriteApi().saveFavouriteImage(imageId: imageId))
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .receive(on: DispatchQueue.main)
                    .map(\.data)
                    .decode(type: SaveFavouriteRes.self, decoder: JSONDecoder())
                    .sink(
                        receiveCompletion: {
                            switch $0 {
                            case .failure(let error):
                                promise(.failure(error))
                            case .finished:
                                return
                            }
                        },
                        receiveValue: {
                            promise(.success($0.message == ServiceConst.success))
                        })
                    .store(in: &self.cancellable)
            }
        }
        .eraseToAnyPublisher()
    }
}
