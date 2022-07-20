//
//  HomeViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/20.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    private let favouriteService = FavouriteService()
    private let voteService = VoteService()
    
    @Published var favourites: [Favourite] = []
    @Published var voteUps: [ImageFull] = []
    
    func getFavouriteImages() {
        favouriteService.getMyFavourites()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: [Favourite].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: {
                    print("Receive Completion \($0)")
                },
                receiveValue: { [weak self] favourites in
                    self?.favourites = favourites
                })
            .store(in: &cancellable)
    }
    
    func getVoteUpImages() {
        voteService.getMyVotes()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: [ImageFull].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: {
                    print("Receive Completion \($0)")
                },
                receiveValue: { [weak self] voteUps in
                    self?.voteUps = voteUps
                })
            .store(in: &cancellable)
    }
}
