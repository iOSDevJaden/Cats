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
    
    func voteImage(image: ImageFull, vote: VoteValue = .up) {
        guard let imageId = image.id else {
            return
        }
        
        // TODO: - Need proper user id for subId member variable of VoteRequest.
        let voteRequest = VoteRequest(
            imageId: imageId,
            subId: image.subId ?? "user-1234",
            value: 1
        )
        
        voteService.createVote(vote: voteRequest)
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
            .map { $0.data }
            .tryMap {
                guard let res = try? JSONDecoder().decode(MessageResponse.self, from: $0) else {
                    return false
                }
                return res.message == "SUCCESS"
            }
            .sink(
                receiveCompletion: {
                    print($0)
                },
                receiveValue: {
                    print($0)
                })
            .store(in: &cancellable)
    }
}

extension VoteViewModel {
    enum VoteValue: Int {
        case up = 1
        case down = 0
    }
}
