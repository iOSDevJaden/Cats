//
//  ImageModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/31.
//

import Foundation

struct ImageModel: Equatable, Codable {
    let imageUrl: String?
    let imageId: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "url"
        case imageId = "id"
    }
    
#if DEBUG
    static let staticImageModel = ImageRes.staticImageRes.mapToImageModel()
#endif
}
