//
//  Resources.swift
//  Cats
//
//  Created by 김태호 on 2022/07/08.
//

import Foundation

extension String {
    static var urlString: String {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "ServerUrl") as? String else {
            fatalError("Service API URL could not find in plist.")
        }
        return urlString
    }
    
    static var apiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("Service API Key could not find in plist.")
        }
        return apiKey
    }
    
    static var apiVersion: String {
        guard let apiVersion = Bundle.main.object(forInfoDictionaryKey: "ApiVersion") as? String else {
            fatalError("Service API Version could not find in plist.")
        }
        return "/\(apiVersion)"
    }
}
