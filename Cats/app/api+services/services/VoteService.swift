//
//  VoteService.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Foundation

struct VoteService {
    private let voteApi = VoteApi()
    
    func getMyVotes() -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: voteApi.getMyVotes())
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
