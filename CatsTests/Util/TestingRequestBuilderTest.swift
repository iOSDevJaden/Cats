//
//  TestingRequestBuilderTest.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/09.
//

import XCTest

class UrlRequestBuilder {
    private var baseUrl: URL
    private var path: String = ""
    
    private var httpHeader: [String: String] = [:]
    private var httpMethod: HttpMethod = .get
    private var httpBody: Data? = nil
    
    private var urlQueryItems: [URLQueryItem] = []
    
    // To make it safer Compile time error occured without `baseUrl`
    public init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    // Path
    public  func setPath(path: String) -> Self {
        self.path = path
        return self
    }
    
    public func setPath(path: String, _ pathVariable: String) -> Self {
        self.path = path + "/" + pathVariable
        return self
    }
    
    public  func setPath(path: String, _ urlQueryItems: [URLQueryItem]) -> Self {
        self.path = path
        self.urlQueryItems = urlQueryItems
        // setQueryItems(urlQueryItems: queryItems)
        return self
    }
    
    public   func addPath(_ path: String) -> Self {
        self.path.append(path)
        return self
    }
    
    public  func addPath(_ path: String, _ pathVariable: String) -> Self {
        self.path.append(path + "/" + pathVariable)
        return self
    }
    
    // Query Items
    public func setQueryItems(urlQueryItems: [URLQueryItem]) -> Self {
        self.urlQueryItems = urlQueryItems
        return self
    }
    
    // Http Method
    public func setHttpMethod(_ httpMehtod: HttpMethod) -> Self {
        self.httpMethod = httpMehtod
        return self
    }
    
    // Http Headers
    public func setHeaders(headers: [String: String]) -> Self {
        self.httpHeader = headers
        return self
    }
    
    // Http Body
    public func setHttpBody(httpBody: Data?) -> Self {
        self.httpBody = httpBody
        return self
    }
    
    private func getURLRequestWithQueryItems(url: URL) -> URLRequest {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = self.urlQueryItems
        
        return URLRequest(url: urlComponents?.url ?? url)
    }
    
    public func build() -> URLRequest {
        let url = self.path.isEmpty ?
        self.baseUrl :
        self.baseUrl.appendingPathComponent(path)
        
        if self.urlQueryItems.isEmpty {
            var urlRequest = URLRequest(url: url)
            urlRequest.allHTTPHeaderFields = self.httpHeader
            urlRequest.httpMethod = self.httpMethod.rawValue.uppercased()
            urlRequest.httpBody = self.httpBody
            return urlRequest
        }
        return getURLRequestWithQueryItems(url: url)
        
    }
    
    enum HttpMethod: String {
        case get
        case post
        case delete
        case put
    }
}

class TestingRequestBuilderTest: XCTestCase {
    private let url = URL(string: "https://example.com")!
    private let header: [String: String] = ["Content-Type": "applicaiton/json"]
    private let path = "/path"
    private let pathVariable = "1234"
    private let httpBody = "{\"key\":\"value\"}".data(using: .utf8)
    
    private let queryItem = URLQueryItem(name: "q", value: "query")
    
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
        let request = UrlRequestBuilder(baseUrl: url)
            .setPath(path: path)
            .build()
        
        XCTAssertEqual(request.url?.path.isEmpty, false)
        XCTAssertEqual(request.url?.path, path)
    }
    
    func test_urlRequestBuilder_setPath_with_path_variable() {
        let request = UrlRequestBuilder(baseUrl: url)
            .setPath(path: path, pathVariable)
            .build()
        
        XCTAssertEqual(request.url?.path, path + "/\(pathVariable)")
    }
    
    func test_urlRequestBuilder_setPath_path_is_not_nil() {
        let request = UrlRequestBuilder(baseUrl: url)
            .setPath(path: path)
            .build()
        
        XCTAssertEqual(request.url?.path, path)
    }
    
    func test_urlRequestBuilder_addPath_is_appended_path() {
        let somePath = "/some"
        let request = UrlRequestBuilder(baseUrl: url)
            .setPath(path: path)
            .addPath(somePath)
            .build()
        
        XCTAssertEqual(request.url?.path, path + somePath)
    }
    
    func test_urlRequestBuilder_addPath_with_path_variable() {
        let somePath = "/some"
        let request = UrlRequestBuilder(baseUrl: url)
            .setPath(path: path)
            .addPath(somePath, pathVariable)
            .build()
        
        XCTAssertEqual(request.url?.path, path + somePath + "/" + pathVariable)
    }
    
    func test_urlRequestBuilder_has_empty_httpHeader_without_setHttpHeader() {
        let request = UrlRequestBuilder(baseUrl: url)
            .build()
        
        XCTAssertEqual(request.allHTTPHeaderFields?.isEmpty, true)
    }
    
    func test_urlRequestBuilder_has_empty_httpHeader_with_setHttpHeaeder() {
        let request = UrlRequestBuilder(baseUrl: url)
            .setHeaders(headers: [:])
            .build()
        
        XCTAssertEqual(request.allHTTPHeaderFields?.isEmpty, true)
    }
    
    func test_urlRequestBuilder_has_not_empty_httpHeader_with_setHttpHeaeder() {
        let request = UrlRequestBuilder(baseUrl: url)
            .setHeaders(headers: header)
            .build()
        
        XCTAssertEqual(request.allHTTPHeaderFields?.isEmpty, false)
    }
    
    func test_urlRequestBuilder_has_same_http_header_with_setHttpHeader() {
        let request = UrlRequestBuilder(baseUrl: url)
            .setHeaders(headers: header)
            .build()
        
        XCTAssertEqual(request.allHTTPHeaderFields, header)
    }
    
    func test_urlRequestBuilder_has_no_query_items_returns_plain_URLReqeust() {
        let request = UrlRequestBuilder(baseUrl: url)
            .setPath(path: path)
            .setQueryItems(urlQueryItems: [/* empty */])
            .build()
        
        XCTAssertEqual(request.url?.path, path)
    }
    
    func test_urlRequestBuilder_has_query_items_setQeuryItems_returns_URLRequest_URL_queryString() {
        let request = UrlRequestBuilder(baseUrl: url)
            .setPath(path: path)
            .setQueryItems(urlQueryItems: [queryItem])
            .build()
        
        let expectedUrl = "https://example.com/path?q=query"
        
        XCTAssertEqual(request.url?.absoluteString, expectedUrl)
    }
    
    func test_urlRequestBuilder_has_query_items_setPath_with_URLQueryItems_return_expected_URL() {
        let request = UrlRequestBuilder(baseUrl: url)
            .setPath(path: path, [queryItem])
            .build()
        
        let expectedUrl = "https://example.com/path?q=query"
        
        XCTAssertEqual(request.url?.absoluteString, expectedUrl)
    }
    
    func test_urlRequestBuilder_returns_URLRequest_has_same_httpMethod() {
        let request = UrlRequestBuilder(baseUrl: url)
            .build()
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertNotEqual(request.httpMethod, "POST")
        XCTAssertNotEqual(request.httpMethod, "DELETE")
        XCTAssertNotEqual(request.httpMethod, "PUT")
    }
    
    func test_urlRequestBuilder_setHttpMethod_returns_URLRequest_with_httpMethod() {
        let request = UrlRequestBuilder(baseUrl: url)
            .setHttpMethod(.post)
            .build()
        
        XCTAssertNotEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertNotEqual(request.httpMethod, "DELETE")
        XCTAssertNotEqual(request.httpMethod, "PUT")
    }
    
    func test_urlRequestBuilder_has_nil_data_without_setHttpBody() {
        let request = UrlRequestBuilder(baseUrl: url)
            .build()
        
        XCTAssertNil(request.httpBody)
    }
    
    func test_urlRequestBuilder_has_empty_data_with_setHttpBody() {
        let request = UrlRequestBuilder(baseUrl: url)
            .setHttpBody(httpBody: Data())
            .build()
        
        XCTAssertNotNil(request.httpBody)
    }
    
    func test_urlRequestBuilder_has_data_with_setHttpBody() {
        let request = UrlRequestBuilder(baseUrl: url)
            .setHttpBody(httpBody: httpBody)
            .build()
        
        XCTAssertNotNil(request.httpBody)
    }
}
