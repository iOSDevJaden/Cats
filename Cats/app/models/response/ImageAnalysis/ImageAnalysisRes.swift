//
//  ImageAnalysisRes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/22.
//

import Foundation

struct ImageAnalysisRes: Codable {
    let imageId: String
    let labels: [String]
    let moderationLabels: [String]
    let vendor: String
    let approved: Int
    let rejected: Int
    
    enum CodingKeys: String, CodingKey {
        case imageId = "image_id"
        case labels = "labels"
        case moderationLabels = "moderation_labels"
        case vendor = "vendor"
        case approved = "approved"
        case rejected = "rejected"
    }
}
