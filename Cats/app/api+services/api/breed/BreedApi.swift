//
//  BreedApi.swift
//  Cats
//
//  Created by 김태호 on 2022/07/09.
//

import Foundation

struct BreedApi: BaseApiProtocol {
    func getBreedList() -> URLRequest {
        return getCommonRequestBuilder()
            .addPath("/breeds")
            .setHttpMethod(.get)
            .build()
    }
    
    func getBreedList(id: String) -> URLRequest {
        let parameter = BreedReq(q: id)
        
        return getCommonRequestBuilder()
            .addPath("/breeds")
            .addPath("/search")
            .setQueryItems(urlQueryItems: parameter.getUrlQuery())
            .setHttpMethod(.get)
            .build()
    }
}
