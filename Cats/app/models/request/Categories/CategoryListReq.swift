//
//  CategoryListReq.swift
//  Cats
//
//  Created by 김태호 on 2022/07/22.
//

import Foundation

struct CategoryListReq: Codable {
    let limit: Int
    let page: Int
}
