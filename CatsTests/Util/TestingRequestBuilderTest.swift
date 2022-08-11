//
//  TestingRequestBuilderTest.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/09.
//

import XCTest

struct UrlRequestBuilder {
    var url: URL? = nil
    var path: String? = nil
    var httpMethod: HttpMethod = .get
    var urlQueryItems: [URLQueryItem] = []
    var httpBody: Data? = nil
    
    func setUrl(url: URL?) -> Self {
        UrlRequestBuilder(url: url,
                          path: self.path,
                          httpMethod: .get,
                          urlQueryItems: self.urlQueryItems,
                          httpBody: self.httpBody)
    }
    
    func setPath(path: String?) -> Self {
        UrlRequestBuilder(url: self.url,
                          path: path,
                          httpMethod: .get,
                          urlQueryItems: self.urlQueryItems,
                          httpBody: self.httpBody)
    }
    
    func setHttpMethod(method: HttpMethod = .get) -> Self {
        UrlRequestBuilder(url: self.url,
                          path: path,
                          httpMethod: method,
                          urlQueryItems: self.urlQueryItems,
                          httpBody: self.httpBody)
    }
    
    func setUrlQueryItems(urlQueryItems: [URLQueryItem]) -> Self {
        UrlRequestBuilder(url: self.url,
                          path: self.path,
                          httpMethod: self.httpMethod,
                          urlQueryItems: urlQueryItems,
                          httpBody: self.httpBody)
    }
    
    func setHttpBody(httpBody: Data?) -> Self {
        UrlRequestBuilder(url: self.url,
                          path: self.path,
                          httpMethod: self.httpMethod,
                          urlQueryItems: self.urlQueryItems,
                          httpBody: httpBody)
    }
    
    enum HttpMethod {
        case get
        case post
        case delete
        case put
    }
}

class TestingRequestBuilderTest: XCTestCase {
    private let testOnlyUrl = URL(string: "https://example.com")
    private let testPath = "/testPath"
    private let testUrlQueryItems = [URLQueryItem(name: "name", value: "value1")]
    
    func test_urlRequestBuilderMemberUrlIsNil() {
        let requestBuilder = UrlRequestBuilder()
        XCTAssertNil(requestBuilder.url)
    }
    
    func test_urlRequestBuilderMemberUrlIsNotNil() {
        let requestBuilder = UrlRequestBuilder(testOnlyUrl)
        XCTAssertNotNil(requestBuilder.url)
    }
    
    func test_urlRequestBuilderSetUrlIsNil() {
        let requestBuilder = UrlRequestBuilder()
            .setUrl(url: nil)
        
        XCTAssertNil(requestBuilder.url)
    }
    
    func test_urlRequestBuilderSetUrlIsNotNil() {
        let requestBuilder = UrlRequestBuilder()
            .setUrl(url: testOnlyUrl)
        
        XCTAssertNotNil(requestBuilder.url)
    }
    
    func test_urlRequestBuilderMemberPathIsNil() {
        let requestBuilder = UrlRequestBuilder()
        
        XCTAssertNil(requestBuilder.path)
    }
    
    func test_urlRequestBuilderMemberPathIsNotNil() {
        let requestBuilder = UrlRequestBuilder(nil, testPath)
        
        XCTAssertNotNil(requestBuilder.path)
    }
    
    func test_urlRequestBuilderSetPathIsNil() {
        let requestBuilder = UrlRequestBuilder()
            .setPath(path: testPath)
        
        XCTAssertNotNil(requestBuilder.path)
    }
    
    func test_urlRequestBuilderSetUrlSetPathNotNil() {
        let requestBuilder = UrlRequestBuilder()
            .setUrl(url: testOnlyUrl)
            .setPath(path: testPath)
        
        XCTAssertNotNil(requestBuilder.url)
        XCTAssertNotNil(requestBuilder.path)
    }
    
    func test_urlRequestBuilderHttpMethodIsGet() {
        let requestBuilder = UrlRequestBuilder()
        
        XCTAssertEqual(UrlRequestBuilder.HttpMethod.get, requestBuilder.httpMethod)
    }
    
    func test_urlRequestBuilderSetHttpMethodIsNotGet() {
        let requestBuilder = UrlRequestBuilder()
            .setHttpMethod(method: .post)
        
        XCTAssertNotEqual(
            UrlRequestBuilder.HttpMethod.get,
            requestBuilder.httpMethod)
    }
    
    func test_urlRequestBuilderSetHttpMethodIsPost() {
        let requestBuilder = UrlRequestBuilder()
            .setHttpMethod(method: .post)
        
        XCTAssertEqual(
            UrlRequestBuilder.HttpMethod.post,
            requestBuilder.httpMethod)
    }
    
    func test_urlRequestBuilderQueryItemsIsEmptyReturnsTrue() {
        let requestBuilder = UrlRequestBuilder()
        
        XCTAssertNotNil(requestBuilder.urlQueryItems)
        XCTAssertTrue(requestBuilder.urlQueryItems.isEmpty)
    }
    
    func test_urlRequestBuilderQueryItemsIsEmptyReturnsFalse() {
        let requestBuilder = UrlRequestBuilder()
            .setUrlQueryItems(urlQueryItems: testUrlQueryItems)
        
        XCTAssertNotNil(requestBuilder.urlQueryItems)
        XCTAssertFalse(requestBuilder.urlQueryItems.isEmpty)
    }
    
}
