//
//  NetworkUtil.swift
//  Cats
//
//  Created by 김태호 on 2022/07/09.
//

import Foundation

enum HttpMethod: String {
    case get,
         post,
         delete
    
    static func getValue(method: Self) -> String {
        switch(method) {
        case .get: return "GET"
        case .post: return "POST"
        case .delete: return "DELETE"
        }
    }
}

extension URLRequest {
    static func getRelativePath(_ path: String = "") -> URLRequest {
        let version = String.apiVersion
        let urlPath = URL.getRelativePath(path: version + path)
        print(urlPath.description)
        var request = URLRequest(url: urlPath)
        request.addValue(String.apiKey, forHTTPHeaderField: "x-api-key")
        return request
    }
}

extension URL {
    private static var baseUrl: URL {
        let urlString = String.urlString
        
        guard let baseUrl = URL(string: urlString)?.absoluteURL else {
            fatalError("Wrong Base URL")
        }
        return baseUrl
    }
    
    static func getRelativePath(path: String) -> URL {
        guard let url = URL(string: path, relativeTo: .baseUrl) else {
            fatalError("Wrong path")
        }
        return url.absoluteURL
    }
}

