//
//  CategoryRes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/09.
//

import Foundation

struct CategoryRes: Codable, Identifiable {
    let id: Int
    let name: String?
    
#if DEBUG
    static let staticCategoryRes = CategoryRes(id: 6, name: "caturday")
#endif
}
