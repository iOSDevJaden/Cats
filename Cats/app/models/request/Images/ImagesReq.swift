//
//  ImagesReq.swift
//  Cats
//
//  Created by 김태호 on 2022/07/22.
//

import Foundation

struct ImagesReq {
    let size: String
    let mimeTypes: [String]
    let order: String
    let limit: Int
    let page: Int
    let categoryIds:[Int]
    let format: String
    let breedId: String
}
