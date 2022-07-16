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
    
    func getAllImages() {
        imagesService.getAllImages(limit: 3)
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { $0.data }
            .decode(type: [ImageFull].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: {
                    print("Receive Completion \($0)")
                },
                receiveValue: { [weak self] images in
                    self?.images.append(contentsOf: images)
                })
            .store(in: &cancellable)
    }
    
    func voteImage(image: ImageFull, vote: VoteValue = .up) {
        guard let imageId = image.id else {
            return
        }
        
        let voteRequest = VoteRequest(
            imageId: imageId,
            subId: UserInfoCache.shared.id,
            value: 1
        )
        
        voteService.createVote(vote: voteRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map { $0.data }
            .decode(type: MessageResponse.self, decoder: JSONDecoder())
            .map { $0.message == "SUCCESS" }
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
