//
//  ImagesService.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Foundation
 
struct ImagesService {
    private let imagesApi = ImagesApi()
    
    func getSingleImage() -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: imagesApi.getSingleImage())
    }
    
    func getAllImages(limit: Int) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: imagesApi.getAllPublicImages(limit: limit))
    }
    
    func getImage(by id: String) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: imagesApi.getImage(by: id))
    }
}
