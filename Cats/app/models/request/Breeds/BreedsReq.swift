//
//  BreedsReq.swift
//  Cats
//
//  Created by 김태호 on 2022/07/22.
//

import Foundation

struct BreedsReq: Codable {
    let attachBreed: Int
    let page: Int
    let limit: Int
}
