//
//  TestBaseApi.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/13.
//

import Foundation
@testable import Cats

struct TestBaseApi: BaseApiProtocol {
    private let baseUrl = URL(string: "https://example.com")!
    private let basePath = "/api/version"
    private let defaultHeader = [
        "x-api-key": "1234"
    ]
    
    func getCommonRequestBuilder() -> RequestBuilder {
        return RequestBuilder(baseUrl: baseUrl)
            .setBasePath(path: basePath)
            .setHttpMethod(.get)
            .setHeaders(headers: defaultHeader)
    }
}
