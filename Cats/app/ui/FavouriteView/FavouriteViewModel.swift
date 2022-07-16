//
//  FavouriteViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation

class FavouriteViewModel: ObservableObject {
    private let favouriteServices = FavouriteService()
    private var cancellable = Set<AnyCancellable>()
    
    @Published var favourites = [Favourite]()
    
    func getMyFavourites() {
        favouriteServices.getMyFavourites()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: [Favourite].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: {
                    print("receiveCompletion \($0)")
                },
                receiveValue: { [weak self] favorites in
                    self?.favourites = favorites
                    self?.favourites.forEach { print($0.id) }
                })
            .store(in: &cancellable)
    }
    
    func deleteFavourites(favouriteId: Int) {
        favouriteServices.deleteMyFavourite(favourite: "\(favouriteId)")
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .sink(
                receiveCompletion: {
                    print("receiveCompletion \($0)")
                },
                receiveValue: {
                    if let str = String(data: $0, encoding: .utf8) {
                        print(str)
                    }
                    
                })
            .store(in: &cancellable)
    }
}
