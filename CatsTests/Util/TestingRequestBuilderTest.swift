//
//  TestingRequestBuilderTest.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/09.
//

import XCTest
@testable import Cats

class TestingRequestBuilderTest: XCTestCase {

    private let url = URL.baseUrl.appendingPathComponent(String.apiVersion)
    
    func testBasicRequestBuilderTest() {
        let requestBuilder = RequestBuilder()
            .setPath(path: "")
            .setMethod(method: .get)
            .build()
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(String.apiKey, forHTTPHeaderField: "x-api-key")
        
        XCTAssertEqual(requestBuilder, request)
    }

}
