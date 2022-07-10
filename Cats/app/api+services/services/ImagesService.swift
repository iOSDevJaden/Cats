//
//  ImagesService.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Foundation
 
struct ImagesService {
    private let imagesApi = ImagesApi()
    
    func getAllImages() -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: imagesApi.getAllPublicImages())
    }
    
    func getImage(by id: String) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: imagesApi.getImage(by: id))
    }
}
