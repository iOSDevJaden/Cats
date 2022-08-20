//
//  TestBaseApi.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/13.
//

import Foundation
@testable import Cats

struct TestBaseApi: BaseApiProtocol {
    private let baseUrl = Const.baseUrl!
    private let basePath = Const.apiVersion
    
    private let defaultHeader = [
        Const.xApiKey: Const.apiKey,
    ]
    
    func getCommonRequestBuilder() -> RequestBuilder {
        return RequestBuilder(baseUrl: baseUrl)
            .setBasePath(path: basePath)
            .setHttpMethod(.get)
            .setHeaders(headers: defaultHeader)
    }
}
