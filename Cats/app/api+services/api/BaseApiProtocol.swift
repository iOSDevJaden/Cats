//
//  BaseApiProtocol.swift
//  Cats
//
//  Created by 김태호 on 2022/08/13.
//

import Foundation

protocol BaseApiProtocol {
    func getCommonRequestBuilder() -> RequestBuilder
}

extension BaseApiProtocol {
    func getCommonRequestBuilder() -> RequestBuilder {
        let commonPath = String.apiVersion
        let commonHttpHeader = ["x-api-key": String.apiKey]
        
        return RequestBuilder(baseUrl: .baseUrl)
            .setPath(path: commonPath) // `/v1`
            .setHeaders(headers: commonHttpHeader)
    }
}
