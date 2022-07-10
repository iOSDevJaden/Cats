//
//  ImagesApi.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Foundation

struct ImagesApi {
    /**
     * Search & Itterate through all public images.
     */
    func getSingleImage() -> URLRequest {
        var request = URLRequest.getRelativePath("/images/search")
        request.httpMethod = HttpMethod.getValue(method: .get)
        return request
    }
    
    func getAllPublicImages(limit: Int, page: Int = 0) -> URLRequest {
        var urlComponents = URLComponents(string: URLRequest.getRelativePath("/images/search").description)
        urlComponents?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            // TODO: - Find a way to handle user settings
            URLQueryItem(name: "size", value: "small"),
        ]
        
        guard let url = urlComponents?.url else {
            fatalError("Wrong URL with query")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.getValue(method: .get)
        return request
    }
    
    /**
     * Gets the image matching the image_id parameter passed.
     * If you are the owner then the full Image response will be present,
     * and any Vote or Favourite matching your account & sub_id will be attached.
     */
    func getImage(by id: String) -> URLRequest {
        var request = URLRequest.getRelativePath("/images/\(id))")
        request.httpMethod = HttpMethod.getValue(method: .get)
        return request
    }
}
