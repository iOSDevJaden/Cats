//
//  VoteService.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation

class VoteService {
    private var cancellable = Set<AnyCancellable>()
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
                                print("Finished")
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
    
    func getMyVotes(vote id: String) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: voteApi.getMyVotes(vote: id))
    }
    
    func createVote(vote req: VoteRequest) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: voteApi.createVote(req))
    }
    
    func deleteVote(vote id: String) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: voteApi.deleteMyVote(vote: id))
    }
}
