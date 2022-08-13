//
//  TestingBaseRequestBuilderTest.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/13.
//

import XCTest
@testable import Cats

class TestingBaseRequestBuilderTest: XCTestCase {
    private let baseApi: BaseApiProtocol = TestBaseApi()

    private let baseUrl = URL(string: "https://example.com")!
    private let basePath = "/api/version"
    
    func test_BaseApi_default_values_url_exists_returns_true() {
        let requestBuilder = getGetCommonURLRequest()
        
        XCTAssertNotNil(requestBuilder.url?.absoluteString)
        XCTAssertEqual(requestBuilder.url?.absoluteString, "https://example.com/api/version")
    }
    
    func test_BaseApi_default_values_httpMethod_exists_returns_true() {
        let requestBuilder = getGetCommonURLRequest()
        
        XCTAssertNotNil(requestBuilder.httpMethod)
        XCTAssertEqual(requestBuilder.httpMethod, "GET")
        
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(
            requestBuilder.allHTTPHeaderFields,
            ["x-api-key": "1234"]
        )
    }
    
    func test_BaseApi_default_values_httpHeaders_exists_returns_true() {
        let requestBuilder = getGetCommonURLRequest()
        
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(
            requestBuilder.allHTTPHeaderFields,
            ["x-api-key": "1234"]
        )
    }
    
    func test_commonRequestBuiler_returns_URLReqeust_for_api() {
        let requestBuilder = baseApi.getCommonRequestBuilder()
            .setHeaders(headers: ["Contnet-Type": "application/json"])
            .setPath(path: "/my-path", "1234")
            .setHttpMethod(.post)
            .build()
        
        let expectedUrl = "https://example.com/api/version/my-path/1234"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "POST"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedHttpHeader = [
            "Contnet-Type": "application/json",
            "x-api-key": "1234",
        ]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }
    
    func test_commonRequestBuiler_returns_URLReqeust_for_api_with_query_items() {
        let requestBuilder = baseApi.getCommonRequestBuilder()
            .setHeaders(headers: ["Contnet-Type": "application/json"])
            .setPath(path: "/my-path")
            .setQueryItems(urlQueryItems: [URLQueryItem(name: "q", value: "1234")])
            .setHttpMethod(.get)
            .build()
        
        let expectedUrl = "https://example.com/api/version/my-path?q=1234"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "GET"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedHttpHeader = [
            "Contnet-Type": "application/json",
            "x-api-key": "1234",
        ]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }

}

// Helper funciton(s)
extension TestingBaseRequestBuilderTest {
    private func getGetCommonURLRequest() -> URLRequest {
        return baseApi
            .getCommonRequestBuilder()
            .build()
    }
}
