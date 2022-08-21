//
//  MockFavouriteService.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/21.
//

import Combine
import Foundation
@testable import Cats

class MockFavouriteService: FavouriteServiceProtocol {
    
    lazy var resultFavourtieModels: AnyPublisher<[FavouriteModel], Error>! = nil
    lazy var resultFavourtieModel: AnyPublisher<FavouriteModel, Error>! = nil
    lazy var resultBool: AnyPublisher<Bool, Error>! = nil
    
    func getMyFavourites() -> AnyPublisher<[FavouriteModel], Error> {
        return resultFavourtieModels
    }
    
    func getMyFavourtie(favourite id: String) -> AnyPublisher<FavouriteModel, Error> {
        return resultFavourtieModel
    }
    
    func deleteMyFavourite(favourite id: String) -> AnyPublisher<Bool, Error> {
        return resultBool
    }
    
    func saveFavouriteImage(id imageId: String) -> AnyPublisher<Bool, Error> {
        return resultBool
    }
}
