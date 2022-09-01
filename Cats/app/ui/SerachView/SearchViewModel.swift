//
//  SearchViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation

final class SearchViewModel: BaseViewModel, ObservableObject {
    private let favouriteService: FavouriteServiceProtocol
    private let imagesService: ImageServiceProtocol
    private let userPreferences: UserPreferences
    
    init(
        favouriteService: FavouriteServiceProtocol = FavouriteService(),
        imagesService: ImageServiceProtocol = ImagesService(),
        userPreferences: UserPreferences = UserPreferences.shared
    ) {
        self.favouriteService = favouriteService
        self.imagesService = imagesService
        self.userPreferences = userPreferences
    }
    
    @Published var images = [ImageModel]()
    @Published var page = 0
    @Published var numberOfImagePerPage = 0
    
    @Published var candidateImageUrl: String?
    
    func loadCurrentPage(key: String? = nil) {
        if let key = key {
            self.page = userPreferences.getCurrentSearchImagePage(key: key)
        }
        self.page = userPreferences.getCurrentSearchImagePage()
    }
    
    func loadNumberOfImagePerPage(key: String? = nil) {
        if let key = key {
            self.numberOfImagePerPage = userPreferences.getCurrentNumberOfImagePerPage(key: key)
        }
        self.numberOfImagePerPage = userPreferences.getCurrentNumberOfImagePerPage()
    }
    
    func updateCurrentPage(key: String? = nil) {
        if let key = key {
            userPreferences.setCurrentSearchImagePage(self.page + 1, key: key)
        }
        userPreferences.setCurrentSearchImagePage(self.page + 1)
    }
    
    func getImages() {
        imagesService.getImages(limit: numberOfImagePerPage, page: page)
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .replaceError(with: [])
            .sink { [weak self] images in
                self?.images.append(contentsOf: images)
            }
            .store(in: &cancellable)
    }
    
    func favouriteImage(imageUrl url: String) {
        guard let id = getFavouriteImageId() else {
            return
        }
        favouriteService.saveFavouriteImage(id: id)
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .replaceError(with: false)
            .sink { [weak self] in
                if $0 { self?.removeFavouriteImage(id) }
                self?.candidateImageUrl = nil
            }
            .store(in: &cancellable)
    }
    
    private func getFavouriteImageId() -> String? {
        images.first(where: { $0.imageUrl == self.candidateImageUrl })?.imageId
    }
    
    private func removeFavouriteImage(_ imageId: String) {
        guard let imageIndex = images.firstIndex(where: { $0.imageId == imageId }) else {
            return
        }
        images.remove(at: imageIndex)
    }
}
