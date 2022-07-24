//
//  RequestBuilder.swift
//  Cats
//
//  Created by 김태호 on 2022/07/11.
//

import Foundation

class RequestBuilder {
    private let baseUrl = URL.baseUrl
    private var path: String = ""
    private var method: HttpMethod = .get
    private var headers: [String: String] = [:]
    private var urlQuery: [URLQueryItem]?
    private var parameters: Data?
    
    func setMethod(method: HttpMethod) -> Self {
        self.method = method
        return self
    }
    
    func setPath(path: String) -> Self {
        self.path = String.apiVersion + path
        return self
    }
    
    func setHeaders(headers: [String: String]) -> Self {
        self.headers = headers
        return self
    }
    
    func setParameters(parameters: Data) -> Self {
        self.parameters = parameters
        return self
    }
    
    func setParameters(urlQuery: [URLQueryItem]) -> Self {
        self.urlQuery = urlQuery
        return self
    }
    
    func build() -> URLRequest {
        guard var component = URLComponents(
            url: baseUrl.appendingPathComponent(path),
            resolvingAgainstBaseURL: true) else {
            fatalError("")
        }
        
        if let urlQuery = self.urlQuery {
            component.queryItems = urlQuery
        }
        
        guard let url =  component.url else {
            fatalError("")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let httpBody = self.parameters {
            request.httpBody = httpBody
        }
        
        request.setValue(
            String.apiKey,
            forHTTPHeaderField: "x-api-key"
        )
        
        print(url.debugDescription)
        
        return request
    }
}
