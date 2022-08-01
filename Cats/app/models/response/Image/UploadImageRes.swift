//
//  UploadImageRes.swift
//  Cats
//
//  Created by 김태호 on 2022/08/01.
//

import Foundation

struct UploadImageRes: Codable {
    let id: String
    let url: String
    let width: Int
    let height: Int
    let originalFileName: String
    let pending: Int
    let approved: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case width = "width"
        case height = "height"
        case originalFileName = "original_fileName"
        case pending = "pending"
        case approved = "approved"
    }
//    {"id":"wZ3DQNnhN","url":"https://cdn2.thecatapi.com/images/wZ3DQNnhN.jpg","width":276,"height":183,"original_filename":"6FF89385-427B-4B43-8A34-B75E613B2510.jpeg","pending":0,"approved":1}
    #if DEBUG
  
    static let staticUploadImageRes = UploadImageRes(
        id: "wZ3DQNnhN",
        url: "https://cdn2.thecatapi.com/images/wZ3DQNnhN.jpg",
        width: 276,
        height: 183,
        originalFileName: "6FF89385-427B-4B43-8A34-B75E613B2510.jpeg",
        pending: 0,
        approved: 1)
    #endif
}
