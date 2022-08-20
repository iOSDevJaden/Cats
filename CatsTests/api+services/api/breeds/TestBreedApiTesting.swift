//
//  TestBreedApiTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/13.
//

import XCTest
@testable import Cats

// MARK: - https://docs.thecatapi.com/api-reference/breeds/breeds-list

class TestBreedApiTesting: XCTestCase {
    private let baseApi: BaseApiProtocol = TestBaseApi()
    
    //GET /breeds
    func test_commonRequestBuiler_returns_URLReqeust_for_breed_api_search_all_breeds() {
        let requestBuilder = baseApi.getCommonRequestBuilder()
            .addPath("/breeds")
            .setHttpMethod(.get)
            .build()
        
        let expectedUrl = "https://api.thecatapi.com/v1/breeds"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "GET"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedHttpHeader = ["x-api-key": "my-api-key"]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }
    
    // GET /breeds/search
    func test_commonRequestBuiler_returns_URLReqeust_for_breed_api_search_breed_id() {
        let requestBuilder = baseApi.getCommonRequestBuilder()
            .addPath("/breeds")
            .addPath("/search")
            .setQueryItems(urlQueryItems: [URLQueryItem(name: "q", value: "query")])
            .setHttpMethod(.get)
            .build()
        
        let expectedUrl = "https://api.thecatapi.com/v1/breeds/search?q=query"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "GET"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedHttpHeader = ["x-api-key": "my-api-key"]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }
}
