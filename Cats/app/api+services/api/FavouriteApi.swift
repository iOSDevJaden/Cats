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
        return RequestBuilder()
            .setPath(path: "/favourites")
            .setMethod(method: .get)
            .build()
    }
    
    /**
     * Get one specific Favourite belonging to your Account
     */
    func getMyFavourites(favourite id: String) -> URLRequest {
        return RequestBuilder()
            .setPath(path: "/favourites/\(id)")
            .setMethod(method: .get)
            .build()
    }
    
    /**
     * Get one specific Favourite belonging to your Account
     */
    func deleteFavourite(favourite id: String) -> URLRequest {
        return RequestBuilder()
            .setPath(path: "/favourites/\(id)")
            .setMethod(method: .delete)
            .build()
    }
}
