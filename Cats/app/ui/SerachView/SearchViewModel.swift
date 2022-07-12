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
    
    @Published var imageFull: ImageFull? = nil
    @Published var images: [ImageFull] = []
    
    func getSingleImage() {
        imagesService.getSingleImage()
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { $0.data }
            .decode(type: [ImageFull].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: {
                    print("Completion \($0)")
                },
                receiveValue: { [weak self] images in
                    self?.images = images
                })
            .store(in: &cancellable)
    }
    
    func findImage(by imageId: String) {
        imagesService.getImage(by: imageId)
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { $0.data }
            .decode(type: ImageFull.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: {
                    print("Completion \($0)")
                },
                receiveValue: { [weak self] image in
                    self?.imageFull = image
                    print("Found image \(imageId) -> \(self?.imageFull?.url ?? "Nothing ")")
                })
            .store(in: &cancellable)
    }
}
