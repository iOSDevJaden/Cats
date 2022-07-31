//
//  FavouriteService.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation

class FavouriteService {
    private var cacellable = Set<AnyCancellable>()
    
    func getMyFavourites() -> AnyPublisher<[FavouriteRes], Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: FavouriteApi().getMyFavourites())
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .receive(on: DispatchQueue.main)
                    .map(\.data)
                    .decode(type: [FavouriteRes].self, decoder: JSONDecoder())
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
                    .store(in: &self.cacellable)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getMyFavourtie(favourite id: String) -> AnyPublisher<FavouriteRes, Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: FavouriteApi().getMyFavourites())
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .receive(on: DispatchQueue.main)
                    .map(\.data)
                    .decode(type: FavouriteRes.self, decoder: JSONDecoder())
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
                    .store(in: &self.cacellable)
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
                    .store(in: &self.cacellable)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func saveFavouriteImage(id imageId: String) -> AnyPublisher<Bool, Error> {
        print("Image ID \(imageId)")
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
                    .store(in: &self.cacellable)
            }
        }
        .eraseToAnyPublisher()
    }
}
