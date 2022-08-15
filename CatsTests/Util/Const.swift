//
//  Const.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/15.
//

import Foundation

enum Const {
    // URL
    static let apiVersion = "/v1"
    static let apiKey = "my-api-key"
    static let subId = "my-sub-id"
    static let baseUrl = URL(string: "https://api.thecatapi.com")
    
    // HTTP
    
    // Headers
    static let xApiKey = "x-api-key"
    static let contentType = "Content-Type"
    static let applicationJson = "application/json"
    
    // Response
    static let messageSuccess = "SUCCESS"
}
