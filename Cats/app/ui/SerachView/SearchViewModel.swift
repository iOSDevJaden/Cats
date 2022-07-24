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
    
    @Published var images: [ImageRes] = []
    @Published var page: Int = 0 {
        didSet { saveImagePage() }
    }
    
    init() {
        setImagePage()
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
    
    func getMoreImages() {
        self.page += 1
        getImages()
    }
    
    private func setImagePage() {
        guard let lastPage = UserDefaults.standard.value(forKey: Const.lastImagePageKey) as? Int else { return }
        self.page = lastPage
    }
    
    private func saveImagePage() {
        UserDefaults.standard.set(page, forKey: Const.lastImagePageKey)
    }
}

extension SearchViewModel {
    enum Const {
        static let defaultImageLimit = 20
        static let lastImagePageKey = "LastImagePageKey"
    }
}
