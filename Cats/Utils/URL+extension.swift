//
//  URL+extension.swift
//  Cats
//
//  Created by 김태호 on 2022/07/11.
//

import Foundation

extension URL {
    static var baseUrl: URL {
        let urlString = String.urlString
        guard let baseUrl = URL(string: urlString)?.absoluteURL else {
            fatalError("Wrong Base URL")
        }
        return baseUrl
    }
}
