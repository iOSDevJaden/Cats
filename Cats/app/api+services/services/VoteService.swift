//
//  VoteService.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation

class VoteService: BaseService {
    private let voteApi = VoteApi()
    
    func getMyVotes() -> AnyPublisher<[VoteRes], Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: self.voteApi.getMyVotes())
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .map(\.data)
                    .decode(type: [VoteRes].self, decoder: JSONDecoder())
                    .sink(
                        receiveCompletion: {
                            switch($0) {
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
    
    func getMyVotes(
        vote id: String
    ) -> AnyPublisher<[VoteRes], Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: self.voteApi.getMyVotes(vote: id))
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .map(\.data)
                    .decode(type: [VoteRes].self, decoder: JSONDecoder())
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
    
    func createVote(vote req: VoteRequest) -> AnyPublisher<Bool, Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: self.voteApi.createVote(req))
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .map(\.data)
                    .decode(type: CreateVoteRes.self, decoder: JSONDecoder())
                    .sink(
                        receiveCompletion: {
                            switch($0) {
                            case .failure(let err): promise(.failure(err))
                            case .finished: return
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
    
    func deleteVote(vote id: String) -> AnyPublisher<Bool, Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: self.voteApi.deleteMyVote(vote: id))
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .map(\.data)
                    .decode(type: DeleteVoteRes.self, decoder: JSONDecoder())
                    .sink(
                        receiveCompletion: {
                            switch($0) {
                            case .failure(let err):
                                promise(.failure(err))
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
