//
//  TestFavouriteApiTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/13.
//

import XCTest
@testable import Cats

// MARK: - https://docs.thecatapi.com/api-reference/favourites/favourites-list

class TestFavouriteApiTesting: XCTestCase {
    private let baseApi: BaseApiProtocol = TestBaseApi()
    
    // GET /favourites
    func test_commonRequestBuiler_returns_URLReqeust_for_favourite_api_get_all_favourites_images() {
        let requestBuilder = baseApi
            .getCommonRequestBuilder()
            .addPath("/favourites")
            .setHttpMethod(.get)
            .build()
        
        let expectedUrl = "https://example.com/api/version/favourites"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "GET"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedHttpHeader = ["x-api-key": "1234"]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }
    
    // GET /favourites/{favourite_id}
    func test_commonRequestBuiler_returns_URLReqeust_for_favourite_api_get_a_favourite_image() {
        let requestBuilder = baseApi
            .getCommonRequestBuilder()
            .addPath("/favourites", "my-favourite-image")
            .setHttpMethod(.get)
            .build()
        
        let expectedUrl = "https://example.com/api/version/favourites/my-favourite-image"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "GET"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedHttpHeader = ["x-api-key": "1234"]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }
    
    // Delete /favourites/{favourite_id}
    func test_commonRequestBuiler_returns_URLReqeust_for_favourite_api_delete_favourite_image() {
        let requestBuilder = baseApi
            .getCommonRequestBuilder()
            .addPath("/favourites", "my-favourite-image")
            .setHttpMethod(.delete)
            .build()
        
        let expectedUrl = "https://example.com/api/version/favourites/my-favourite-image"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "DELETE"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedHttpHeader = ["x-api-key": "1234"]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }
    
    //POST /favourites/
    func test_commonRequestBuiler_returns_URLReqeust_for_favourite_api_save_favourite_image() {
        let myFavouriteData = "{\"image_id\":\"favourite image id\", \"sub_id\":\"user-id\"}".data(using: .utf8)
        
        let requestBuilder = baseApi
            .getCommonRequestBuilder()
            .addPath("/favourites", "my-favourite-image")
            .setHttpMethod(.post)
            .setHttpBody(httpBody: myFavouriteData)
            .build()
        
        let expectedUrl = "https://example.com/api/version/favourites/my-favourite-image"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "POST"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedData = myFavouriteData
        XCTAssertNotNil(requestBuilder.httpBody)
        XCTAssertEqual(requestBuilder.httpBody, expectedData)
        
        let expectedHttpHeader = ["x-api-key": "1234"]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }
}
