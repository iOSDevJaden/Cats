//
//  RequestBuilder.swift
//  Cats
//
//  Created by 김태호 on 2022/07/11.
//

import Foundation

final class RequestBuilder {
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
    public func setBasePath(path: String) -> Self {
        self.path = path + self.path
        return self
    }
    
    public func setPath(path: String) -> Self {
        self.path += path
        return self
    }
    
    public func setPath(path: String, _ pathVariable: String) -> Self {
        self.path += path + "/" + pathVariable
        return self
    }
    
    public func setPath(path: String, _ urlQueryItems: [URLQueryItem]) -> Self {
        self.path += path
        self.urlQueryItems = urlQueryItems
        return self
    }
    
    public func addPath(_ path: String) -> Self {
        self.path.append(path)
        return self
    }
    
    public func addPath(_ path: String, _ pathVariable: String) -> Self {
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
        headers.forEach {
            self.httpHeader.updateValue($0.value, forKey: $0.key)
        }
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
//            urlRequest.allHTTPHeaderFields = self.httpHeader
            self.httpHeader.forEach {
                urlRequest.addValue($0.value,
                                    forHTTPHeaderField: $0.key)
            }
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

