//
//  BreedApi.swift
//  Cats
//
//  Created by 김태호 on 2022/07/09.
//

import Foundation

struct BreedApi {
    func getBreedList() -> URLRequest {
        return RequestBuilder()
            .setPath(path: "/breeds")
            .setMethod(method: .get)
            .build()
    }
    
    func getBreedList(id: String) -> URLRequest {
        let parameter = BreedReq(q: id)
        
        return RequestBuilder()
            .setPath(path: "/breeds/search")
            .setParameters(urlQuery: parameter.getUrlQuery())
            .setMethod(method: .get)
            .build()
    }
}
