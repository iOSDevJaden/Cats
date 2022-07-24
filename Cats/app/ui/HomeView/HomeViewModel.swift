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
    
    @Published var favourites: [FavouriteRes] = []
    @Published var voteUps: [VoteRes] = []
    
    func getFavouriteImages() {
        favouriteService.getMyFavourites()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
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
            .sink(
                receiveCompletion: {
                    print("Receive Completion \($0)")
                },
                receiveValue: { [weak self] vote in
                    self?.voteUps = vote
                })
            .store(in: &cancellable)
    }
    
    func deleteVote(imageId: String) {
        voteService.deleteVote(vote: imageId)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: {
                    print("Receive Completion \($0)")
                },
                receiveValue: {
                    print("Receive Value = \($0)")
                })
            .store(in: &cancellable)
    }
}
