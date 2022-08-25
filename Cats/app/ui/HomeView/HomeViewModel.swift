//
//  HomeViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/20.
//

import Combine
import Foundation

class HomeViewModel: BaseViewModel, ObservableObject {
    private let favouriteService: FavouriteServiceProtocol
    private let userPreferences: UserPreferences
    private let cacheManager: CacheManager
    
    @Published var favouriteImages = [FavouriteModel]()
    
    init(
        favouriteService: FavouriteServiceProtocol = FavouriteService(),
        userPreferences: UserPreferences = UserPreferences.shared,
        cacheManager: CacheManager = CacheManager.shared
    ) {
        self.favouriteService = favouriteService
        self.userPreferences = userPreferences
        self.cacheManager = cacheManager
    }
    
    func getFavouriteImages() {
        favouriteService.getMyFavourites()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .sink(
                receiveValue: { [weak self] favouriteImages in
                    self?.favouriteImages = favouriteImages
                })
            .store(in: &cancellable)
    }
    
    func deleteFavouriteImage(image id: String) {
        favouriteService.deleteMyFavourite(favourite: id)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .replaceError(with: false)
            .sink(
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
