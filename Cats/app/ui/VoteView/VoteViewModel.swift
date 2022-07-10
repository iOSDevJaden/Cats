//
//  VoteViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/08.
//

import Combine
import Foundation

class VoteViewModel: ObservableObject {
    private lazy var imagesService = ImagesService()
    private lazy var voteService = VoteService()
    
    private var cancellable = Set<AnyCancellable>()
    
    @Published var images: [ImageFull] = []
    
    func getSingleImage() {
        imagesService.getSingleImage()
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { $0.data }
            .decode(type: [ImageFull].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: {
                    print("Receive Completion \($0)")
                },
                receiveValue: { [weak self] images in
                    self?.images = images
                    self?.images.forEach {
                        print("Image Url \($0.url ?? "Nothing")")
                    }
                })
            .store(in: &cancellable)
    }
    
    func getAllImages() {
        imagesService.getAllImages(limit: 10)
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { $0.data }
            .decode(type: [ImageFull].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: {
                    print("Receive Completion \($0)")
                },
                receiveValue: { [weak self] images in
                    self?.images = images
                    self?.images.forEach {
                        print("Image Url \($0.url ?? "Nothing")")
                    }
                })
            .store(in: &cancellable)
    }
}
