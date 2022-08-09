//
//  BreedReq.swift
//  Cats
//
//  Created by 김태호 on 2022/07/22.
//

import Foundation

struct BreedReq {
    let q: String
    
    func getUrlQuery() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "q", value: self.q),
        ]
    }
}
