//
//  FavouriteApi.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Foundation

struct FavouriteApi {
    /**
     * Get the Favourites belonging to your account, with the
     * option to filter by ‘sub_id’ used when creating them.
     */
    func getMyFavourites() -> URLRequest {
        var request = URLRequest.getRelativePath("/favourites")
        request.httpMethod = HttpMethod.getValue(method: .get)
        return request
    }

    /**
     * Get one specific Favourite belonging to your Account
     */
    func getMyFavourites(favourite id: String) -> URLRequest {
        var request = URLRequest.getRelativePath("/favourites/\(id)")
        request.httpMethod = HttpMethod.getValue(method: .get)
        return request
    }
    
    /**
     * Get one specific Favourite belonging to your Account
     */
    func deleteFavourite(favourite id: String) -> URLRequest {
        var request = URLRequest.getRelativePath("/favourites/\(id)")
        request.httpMethod = HttpMethod.getValue(method: .delete)
        return request
    }
}
