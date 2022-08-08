//
//  RequestBuilder.swift
//  Cats
//
//  Created by 김태호 on 2022/07/11.
//

import Foundation

class RequestBuilder {
    private let baseUrl = URL.baseUrl
    private lazy var path: String = ""
    private lazy var method: HttpMethod = .get
    private lazy var headers: [String: String] = [:]
    private lazy var urlQuery: [URLQueryItem]? = nil
    private lazy var parameters: Data? = nil
    
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
    
    func setParameters(parameters: Data?) -> Self {
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
            // TODO: - Find Another way to remove fatal Error
            fatalError("")
        }
        
        if let urlQuery = self.urlQuery {
            component.queryItems = urlQuery
        }
        
        guard let url =  component.url else {
            // TODO: - Find Another way to remove fatal Error
            fatalError("")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let httpBody = self.parameters {
            request.httpBody = httpBody
        }
        
        // Adding Request headers
        headers.forEach {
            request.addValue(
                $0.value,
                forHTTPHeaderField: $0.key
            )
        }
        
        // All the cat api needs the following header.
        // x-api-key: my-key
        request.addValue(
            String.apiKey,
            forHTTPHeaderField: Const.xApiKey
        )
        
        print(url.debugDescription)
        
        return request
    }
}

extension RequestBuilder {
    enum Const {
        static let xApiKey = "x-api-key"
    }
}
