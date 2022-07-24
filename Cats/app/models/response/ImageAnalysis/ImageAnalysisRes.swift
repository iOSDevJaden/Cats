//
//  ImageAnalysisRes.swift
//  Cats
//
//  Created by 김태호 on 2022/07/22.
//

import Foundation

/**
 * MARK: - Wrong Information
 * The following structure is not correct information
 * https://docs.thecatapi.com/api-reference/models/imageanalysis
 * struct ImageAnalysisRes: Codable {
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
} */

struct ImageAnalysisRes: Codable {
    let id: String
    let url: String
    let subId: String?
    let width: Int
    let height: Int
    let originalFilename: String
    let pending: Int
    let apporoved: Int
    
    enum CodingKeys: String, CodingKey {
        case id = " id"
        case url = " url"
        case subId = " sub_id"
        case width = " width"
        case height = " height"
        case originalFilename = " original_filename"
        case pending = " pending"
        case apporoved = " apporoved"
    }
}
