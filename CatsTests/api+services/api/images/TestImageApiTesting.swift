//
//  TestImageApiTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/13.
//

import XCTest
@testable import Cats

// MARK: - https://docs.thecatapi.com/api-reference/images/images-search

class TestImageApiTesting: XCTestCase {
    
    private let baseApi: BaseApiProtocol = TestBaseApi()
    
    // Get all public Images
    func test_commonRequestBuiler_returns_URLReqeust_for_image_api_get_all_images() {
        let requestBuilder = baseApi
            .getCommonRequestBuilder()
            .addPath("/images")
            .addPath("/search")
            .setQueryItems(urlQueryItems: [URLQueryItem(name: "limit", value: "5")])
            .setHttpMethod(.get)
            .build()
        
    
        let expectedUrl = "https://api.thecatapi.com/v1/images/search?limit=5"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "GET"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedHttpHeader = ["x-api-key": "my-api-key"]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }
    
    func test_commonRequestBuiler_returns_URLReqeust_for_image_api_get_all_images_with_mime_types() {
        let requestBuilder = baseApi
            .getCommonRequestBuilder()
            .addPath("/images")
            .addPath("/search")
            .setQueryItems(urlQueryItems: [URLQueryItem(name: "mime_types", value: "jpg,png")])
            .setHttpMethod(.get)
            .build()
        
        let expectedUrl = "https://api.thecatapi.com/v1/images/search?mime_types=jpg,png"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "GET"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedHttpHeader = ["x-api-key": "my-api-key"]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }
    
    // Get your uploaded Image
    func test_commonRequestBuiler_returns_URLReqeust_for_image_api_get_uploaded_images() {
        let requestBuilder = baseApi
            .getCommonRequestBuilder()
            .addPath("/images")
            .addPath("/search")
            .setQueryItems(urlQueryItems: [URLQueryItem(name: "limit", value: "5")])
            .setHttpMethod(.get)
            .build()
        
        let expectedUrl = "https://api.thecatapi.com/v1/images/search?limit=5"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "GET"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedHttpHeader = ["x-api-key": "my-api-key"]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }
    
    // Upload a specific Image
    func test_commonRequestBuiler_returns_URLReqeust_for_image_api_upload_user_image() {
        let multipartformData = "multipart form data".data(using: .utf8)
        
        let requestBuilder = baseApi
            .getCommonRequestBuilder()
            .addPath("/images")
            .addPath("/upload")
            .setHttpMethod(.post)
            .setHeaders(headers: ["Content-Type": "multipart/form-data; boundary=---myBoundary"])
            .setHttpBody(httpBody: multipartformData)
            .build()
        
    
        let expectedUrl = "https://api.thecatapi.com/v1/images/upload"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "POST"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedHttpHeader = [
            "x-api-key": "my-api-key",
            "Content-Type": "multipart/form-data; boundary=---myBoundary"
        ]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }
    
    // Get Image
    func test_commonRequestBuiler_returns_URLReqeust_for_image_api_get_an_image() {
        let requestBuilder = baseApi
            .getCommonRequestBuilder()
            .addPath("/images", "imageId")
            .setHttpMethod(.get)
            .build()
        
        let expectedUrl = "https://api.thecatapi.com/v1/images/imageId"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "GET"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedHttpHeader = [
            "x-api-key": "my-api-key",
        ]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }
    
    // Delete an uploaded Image
    func test_commonRequestBuiler_returns_URLReqeust_for_image_api_delete_image() {
        let requestBuilder = baseApi
            .getCommonRequestBuilder()
            .addPath("/images", "imageId")
            .setHttpMethod(.delete)
            .build()
        
        let expectedUrl = "https://api.thecatapi.com/v1/images/imageId"
        XCTAssertEqual(requestBuilder.url?.absoluteString, expectedUrl)
        
        let expectedHttpMethod = "DELETE"
        XCTAssertEqual(requestBuilder.httpMethod, expectedHttpMethod)
        
        let expectedHttpHeader = [
            "x-api-key": "my-api-key",
        ]
        XCTAssertNotNil(requestBuilder.allHTTPHeaderFields)
        XCTAssertEqual(requestBuilder.allHTTPHeaderFields, expectedHttpHeader)
    }
}
