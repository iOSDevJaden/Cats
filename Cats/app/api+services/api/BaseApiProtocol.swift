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
    var subId: String {
        return .userId
    }
    
    private var commonPath: String { String.apiVersion }
    
    private var commonHeader: [String: String] {
        let commonHttpHeaderKey = "x-api-key"
        let commonHttpHeaderValue = String.apiKey
        return [commonHttpHeaderKey: commonHttpHeaderValue]
    }
    
    func getCommonRequestBuilder() -> RequestBuilder {
        return RequestBuilder(baseUrl: .baseUrl)
            .setPath(path: commonPath)
            .setHeaders(headers: commonHeader)
    }
}
