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
        var request = URLRequest.getRelativePath("/votes")
        request.httpMethod = HttpMethod.getValue(method: .get)
        return request
    }
    
    /**
     * Get one specific Vote belonging to your Account
     */
    func getMyVotes(vote id: String) -> URLRequest {
        var request = URLRequest.getRelativePath("/votes/\(id)")
        request.httpMethod = HttpMethod.getValue(method: .get)
        return request
    }
    
    /**
     * Vote an Image Up or Down
     */
    func createVote(_ req: VoteRequest) -> URLRequest {
        let httpBody = try? JSONEncoder().encode(req)
        
        var request = URLRequest.getRelativePath("/votes")
        request.httpMethod = HttpMethod.getValue(method: .post)
        request.httpBody = httpBody
        return request
    }
    /**
     * Delete a Vote from your Account.
     */
    func deleteMyVote(vote id: String) -> URLRequest {
        var request = URLRequest.getRelativePath("/votes/\(id)")
        request.httpMethod = HttpMethod.getValue(method: .delete)
        return request
    }
}
