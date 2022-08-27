//
//  SearchViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation

class SearchViewModel: BaseViewModel, ObservableObject {
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
    
    @Published var images: [ImageModel] = []
    @Published var page: Int = 0 {
        didSet { saveImagePage() }
    }
    
    func getImages() {
        imagesService.getImages(limit: Const.defaultImageLimit, page: page)
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .sink(
                receiveCompletion: {
                    print("Completion \($0)")
                },
                receiveValue: { [weak self] images in
                    self?.images.append(contentsOf: images)
                })
            .store(in: &cancellable)
    }
    
    func favouriteImage(imageId id: String) {
        favouriteService.saveFavouriteImage(id: id)
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .sink(
                receiveCompletion: {
                    print("Completion \($0)")
                },
                receiveValue: {
                    print("Save image as an favourite \($0 ? "success" : "failed.")")
                })
            .store(in: &cancellable)
    }
    
    enum Const {
        static let defaultImageLimit = 20
        static let lastImagePageKey = "LastImagePageKey"
    }
}
