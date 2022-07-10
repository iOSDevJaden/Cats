//
//  FavouriteService.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Foundation

struct FavouriteService {
    private let favouriteApi = FavouriteApi()
    
    func getMyFavourites() -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: favouriteApi.getMyFavourites())
    }
    
    func getMyFavourties(favourite id: String) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: favouriteApi.getMyFavourites(favourite: id))
    }
    
    func deleteMyFavourite(favourite id: String) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: favouriteApi.deleteFavourite(favourite: id))
    }
}
