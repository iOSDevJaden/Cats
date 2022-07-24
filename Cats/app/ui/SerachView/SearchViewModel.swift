//
//  SearchViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation

class SearchViewModel: ObservableObject {
    private let imagesService = ImagesService()
    private let voteService = VoteService()
    private var cancellable = Set<AnyCancellable>()
    private var defaultImageLimit = 20
    
    @Published var images: [ImageRes] = []
    @Published var page = 0
    
    func getImages() {
        imagesService.getImages(limit: defaultImageLimit, page: page)
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
    
    func getMoreImages() {
        self.page += 1
        getImages()
    }
}
