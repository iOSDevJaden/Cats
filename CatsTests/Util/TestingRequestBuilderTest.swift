//
//  TestingRequestBuilderTest.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/09.
//

import XCTest

class UrlRequestBuilder {
    var baseUrl: URL
    var path: String = ""
    
    var httpHeader: [String: String] = [:]
    var httpMethod: HttpMethod = .get
    var httpBody: Data? = nil
    
    var urlQueryItems: [URLQueryItem] = []
    
    // To make it safer Compile time error occured without `baseUrl`
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func setPath(path: String) -> Self {
        self.path = path
        return self
    }
    
    func setPath(path: String, _ pathVariable: String) -> Self {
        self.path = path + "/" + pathVariable
        return self
    }
    
    func addPath(_ path: String) -> Self {
        self.path.append(path)
        return self
    }
    
    func addPath(_ path: String, _ pathVariable: String) -> Self {
        self.path.append(path + "/" + pathVariable)
        return self
    }
    
    func build() -> URLRequest {
        let url = self.path.isEmpty ?
        self.baseUrl :
        self.baseUrl.appendingPathComponent(path)
        
        var urlRequest = URLRequest(url: url)
        
        return urlRequest
    }
    
    enum HttpMethod: String {
        case get
        case post
        case delete
        case put
    }
    
    enum BuilderError: Error {
        case invalidUrl
        case invalidHttpMethod
    }
}

class TestingRequestBuilderTest: XCTestCase {
    private let url = URL(string: "https://example.com")!
    
    func test_urlRequestBuilder_initialize_with_proper_url() {
        let request = UrlRequestBuilder(baseUrl: url)
            .build()
        
        XCTAssertEqual(request.url, url)
    }
    
    func test_urlRequestBuilder_setPath_path_is_empty() {
        let request = UrlRequestBuilder(baseUrl: url)
            .build()
        
        XCTAssertEqual(request.url?.path.isEmpty, true)
    }
    
    func test_urlRequestBuilder_setPath_path_is_not_empty() {
        let path = "/path"
        let request = UrlRequestBuilder(baseUrl: url)
            .setPath(path: path)
            .build()
        
        XCTAssertEqual(request.url?.path.isEmpty, false)
        XCTAssertEqual(request.url?.path, path)
    }
    
    func test_urlRequestBuilder_setPath_with_path_variable() {
        let path = "/path"
        let pathVariable = "1234"
        let request = UrlRequestBuilder(baseUrl: url)
            .setPath(path: path, pathVariable)
            .build()
        
        XCTAssertEqual(request.url?.path, path + "/\(pathVariable)")
    }
    
    func test_urlRequestBuilder_setPath_path_is_not_nil() {
        let path = "/path"
        let request = UrlRequestBuilder(baseUrl: url)
            .setPath(path: path)
            .build()
        
        XCTAssertEqual(request.url?.path, path)
    }
    
    func test_urlRequestBuilder_addPath_is_appended_path() {
        let path = "/path"
        let somePath = "/some"
        let request = UrlRequestBuilder(baseUrl: url)
            .setPath(path: path)
            .addPath(somePath)
            .build()
        
        XCTAssertEqual(request.url?.path, path + somePath)
    }
    
    func test_urlRequestBuilder_addPath_with_path_variable() {
        let path = "/path"
        let somePath = "/some"
        let variable = "1234"
        let request = UrlRequestBuilder(baseUrl: url)
            .setPath(path: path)
            .addPath(somePath, variable)
            .build()
        
        XCTAssertEqual(request.url?.path, path + somePath + "/" + variable)
    }
}
