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
    private var cancellable = Set<AnyCancellable>()
    
    @Published var images: [ImageRes] = []
    
    func getSingleImage() {
        imagesService.getImages()
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .sink(
                receiveCompletion: {
                    print("Completion \($0)")
                },
                receiveValue: { [weak self] images in
                    self?.images = images
                })
            .store(in: &cancellable)
    }
}
