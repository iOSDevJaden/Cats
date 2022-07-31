//
//  ImageRes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/21.
//

import Foundation

struct ImageRes: Codable, Identifiable {
    let id: String
    let url: String
    // 2022.07.31 -> Response structure has been changed
    // let subId: String?
    // let createdAt: String?
    // let originalFilename: String?
    let width: Int
    let height: Int
    let pending: Int
    let approved: Int
    let rejected: Int
    
    let categories: [CategoryRes]?
    let breeds: [BreedRes]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        
        case width = "width"
        case height = "height"
        case pending = "pending"
        case approved = "approved"
        case rejected = "rejected"
        
        case categories = "categories"
        case breeds = "breeds"
    }
    
    func mapToImageModel() -> ImageModel {
        return ImageModel(
            imageUrl: url,
            imageId: id)
    }
    
#if DEBUG
    static let staticImageRes = ImageRes(
        id: "se",
        url: "https://24.media.tumblr.com/tumblr_m294stk8SQ1qzex9io1_250.jpg",
        width: 320,
        height: 240,
        pending: 0,
        approved: 1,
        rejected: 0,
        categories: [.staticCategoryRes,] ,
        breeds: [.staticBreed])
#endif
}
