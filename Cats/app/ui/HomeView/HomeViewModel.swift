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
    
    @Published var favouriteImages = [FavouriteModel]()
    
    func getFavouriteImages() {
        favouriteService.getMyFavourites()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: {
                    print("Receive Completion \($0)")
                },
                receiveValue: { [weak self] favouriteImages in
                    self?.favouriteImages = favouriteImages
                })
            .store(in: &cancellable)
    }
    
    func deleteFavouriteImage(image id: String) {
        favouriteService.deleteMyFavourite(favourite: id)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: {
                    print("Receive Completion \($0)")
                },
                receiveValue: { [weak self] in
                    if $0 == true {
                        self?.deleteImage(favouriteId: id)
                        print("Image Delete from favourite Success")
                    } else {
                        print("Image Delete from favourite failed")
                    }
                })
            .store(in: &cancellable)
    }
    
    func deleteImage(favouriteId: String) {
        guard let imageIndex = self.favouriteImages
            .firstIndex(where: { $0.favouriteId == favouriteId }) else {
            return
        }
        
        self.favouriteImages.remove(at: imageIndex)
    }
}
