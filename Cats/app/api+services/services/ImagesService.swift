//
//  ImagesService.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Combine
import Foundation

protocol ImageServiceProtocol {
    func getImages(limit: Int, page: Int) -> AnyPublisher<[ImageModel], Error>
    func getSingleImage() -> AnyPublisher<ImageModel, Error>
    func getImage(id imageId: String) -> AnyPublisher<ImageModel, Error>
    func uploadImage(image: Data) -> AnyPublisher<Bool, Error>
}

class ImagesService: BaseService {
    
    func getImages(limit: Int, page: Int) -> AnyPublisher<[ImageModel], Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: ImagesApi().getAllPublicImages(limit: limit, page: page))
                    .receive(on: DispatchQueue.global(qos: .background))
                    .subscribe(on: DispatchQueue.main)
                    .map(\.data)
                    .decode(type: [ImageRes].self, decoder: JSONDecoder())
                    .map { imageRes in
                        var imageModels: [ImageModel] = []
                        imageRes.forEach {
                            imageModels.append($0.mapToImageModel())
                        }
                        return imageModels
                    }
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
    
    func getSingleImage() -> AnyPublisher<ImageModel, Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: ImagesApi().getSingleImage())
                    .receive(on: DispatchQueue.global(qos: .background))
                    .subscribe(on: DispatchQueue.main)
                    .map(\.data)
                    .decode(type: ImageRes.self, decoder: JSONDecoder())
                    .map { $0.mapToImageModel() }
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
    
    func getImage(id imageId: String) -> AnyPublisher<ImageModel, Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: ImagesApi().getImage(by: imageId))
                    .receive(on: DispatchQueue.global(qos: .background))
                    .subscribe(on: DispatchQueue.main)
                    .map(\.data)
                    .decode(type: ImageRes.self, decoder: JSONDecoder())
                    .map { $0.mapToImageModel() }
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
    
    func uploadImage(image: Data) -> AnyPublisher<Bool, Error> {
        return Deferred {
            Future { promise in
                URLSession.shared.dataTaskPublisher(for: ImagesApi().getImageUpload(image: image))
                    .receive(on: DispatchQueue.global(qos: .background))
                    .subscribe(on: DispatchQueue.main)
                    .map(\.data)
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
                            print("S \(String(data: $0, encoding: .utf8) ?? "")")
                            promise(.success(true))
                        })
                    .store(in: &self.cancellable)
            }
        }
        .eraseToAnyPublisher()
    }
}
