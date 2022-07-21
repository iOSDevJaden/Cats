//
//  GetUploadImagesReq.swift
//  Cats
//
//  Created by 김태호 on 2022/07/22.
//

import Foundation

struct GetUploadImagesReq {
    let limit: Int
    let page: Int
    let order: String
    let subId: String
    
    let breedId: [String]
    let categoryId: [String]
    let originalFileName: String
    
    let format: String
    let includeVote: Int // 0, 1
    let includeFavourite: Int // 0, 1
}
