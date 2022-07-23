//
//  ImagesService.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation
 
class ImagesService {
    private var cancellable = Set<AnyCancellable>()
    private let imagesApi = ImagesApi()
    
    func getImages() -> AnyPublisher<[ImageRes], Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: self.imagesApi.getSingleImage())
                    .receive(on: DispatchQueue.global(qos: .background))
                    .subscribe(on: DispatchQueue.main)
                    .map(\.data)
                    .decode(type: [ImageRes].self, decoder: JSONDecoder())
                    .sink(
                        receiveCompletion: {
                            switch($0) {
                            case .failure(let error):
                                promise(.failure(error))
                            case .finished:
                                return
                            }
                        },
                        receiveValue: {
                            promise(.success($0))
                        })
                    .store(in: &self.cancellable)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getImages(id imageId: String) -> AnyPublisher<ImageRes, Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: self.imagesApi.getSingleImage())
                    .receive(on: DispatchQueue.global(qos: .background))
                    .subscribe(on: DispatchQueue.main)
                    .map(\.data)
                    .decode(type: ImageRes.self, decoder: JSONDecoder())
                    .sink(
                        receiveCompletion: {
                            switch($0) {
                            case .failure(let error):
                                promise(.failure(error))
                            case .finished:
                                return
                            }
                        },
                        receiveValue: {
                            promise(.success($0))
                        })
                    .store(in: &self.cancellable)
            }
        }
        .eraseToAnyPublisher()
    }
}
