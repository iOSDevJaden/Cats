//
//  BreedApi.swift
//  Cats
//
//  Created by 김태호 on 2022/07/09.
//

import Foundation

struct BreedApi {
    func getBreedList() -> URLRequest {
        var request = URLRequest.getRelativePath("/breeds")
        request.httpMethod = HttpMethod.getValue(method: .get)
        return request
    }
    
    func getBreedList(id: String) -> URLRequest {
        var urlComponents = URLComponents(string: URLRequest.getRelativePath("/breeds/search").description)
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: id),
        ]
        
        guard let url = urlComponents?.url else {
            fatalError("Wrong URL with query")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.getValue(method: .get)
        return request
    }
}
