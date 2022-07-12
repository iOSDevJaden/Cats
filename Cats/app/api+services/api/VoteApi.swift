//
//  VoteApi.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Foundation

struct VoteApi {
    /**
     * Returns all the Votes belonging to your Account.
     * You can filter them with the ‘sub_id’ query parameter, and
     * Paginate through them using ‘limit’, ‘page’ and the ‘Pagination-Count’ on the response.
     */
    func getMyVotes() -> URLRequest {
        return RequestBuilder()
            .setPath(path: "/votes")
            .setMethod(method: .get)
            .build()
    }
    
    /**
     * Get one specific Vote belonging to your Account
     */
    func getMyVotes(vote id: String) -> URLRequest {
        return RequestBuilder()
            .setPath(path: "/votes/\(id)")
            .setMethod(method: .get)
            .build()
    }
    
    /**
     * Vote an Image Up or Down
     */
    func createVote(_ req: VoteRequest) -> URLRequest {
        guard let data = try? JSONEncoder().encode(req) else {
            fatalError("Encoding Failed")
        }
        return RequestBuilder()
            .setPath(path: "/votes")
            .setHeaders(headers: ["Content-Type": "application/json"])
            .setMethod(method: .post)
            .setParameters(parameters: data)
            .build()
    }
    /**
     * Delete a Vote from your Account.
     */
    func deleteMyVote(vote id: String) -> URLRequest {
        return RequestBuilder()
            .setPath(path: "/votes/\(id)")
            .setMethod(method: .delete)
            .build()
    }
}
