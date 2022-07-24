//
//  ImagesReq.swift
//  Cats
//
//  Created by 김태호 on 2022/07/22.
//

import Foundation

/* MARK: - Documentation
 *   size: The size of image to return
 *      - small, med or full. small is perfect for Discord. Defaults to med
 *   mimeTypes: Comma delimited string of the image types to return gif, jpg, orpng.
 *      - Defaults to return all types jpg,gif,png.
 *   order: The order to return results in. RANDOM, ASC or DESC.
 *      - If either ASC or DESC is passed then the Pagination headers will be on the response allowing you
 *          to see the total amount of results, and your current page.
 *      - Default is RANDOM
 *   limit:Integer - number of results to return.
 *      - Without an API Key you can only pass 1, with a Key you can pass up to 25. Default is 1
 *   page:Integer - used for Paginating through all the results.
 *      - Only used when order is ASC or DESC
 *   categoryIds: Comma delimited string of integers, matching the id's of the Categories to filter the search.
 *      - These categories can found in the /v1/categories request. e.g. category_ids=2
 *   format: Response format json, orsrc.
 *      - src will redirect straight to the image,
 *          so is useful for putting a link straight into HTML as the 'src' on an 'img' tag.
 *      - Defaults to json
 *   breedId: Comma delimited string of integers, matching the id's of the Breeds to filter the search.
 *      - These categories can found in the /v1/breeds request
 *   breedsIncluded: Only return images which have breed data attached.
 *      - Integer - 0 or 1. Default is 0
 */

struct ImagesReq {
    let size: ImageSize
    let mimeTypes: [MimeType]
    let order: Order
    let limit: Int
    let page: Int
    let categoryIds: [Int]?
    let format: Format
    let breedId: String?
    let breedsIncluded: Bool
    
    private func getMimeTypes() -> String {
        return mimeTypes.map { $0.rawValue }
            .joined(separator: ",")
    }
    
    private func getCategoryIds() -> String {
        guard let categoryIds = categoryIds else {
            return ""
        }
        
        return categoryIds.isEmpty ? "" : categoryIds.map { String($0) }.reduce("", +)
        
    }
    
    func getUrlQueries() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "size", value: "\(size)"),
            URLQueryItem(name: "mimeTypes", value: "\(getMimeTypes())"),
            URLQueryItem(name: "order", value: "\(order)"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "page", value: "\(page)"),
            // URLQueryItem(name: "categoryIds", value: getCategoryIds()),
            URLQueryItem(name: "format", value: "\(format)"),
            // URLQueryItem(name: "breedId", value: "\(breedId ?? "")"),
            URLQueryItem(name: "breedsIncluded", value: "\(breedsIncluded ? 1 : 0)"),
        ]
    }
}

extension ImagesReq {
    enum ImageSize: String {
        case small,
             med,
             full
    }
    
    enum Order {
        case asc,
             desc,
             random
    }
    
    enum MimeType: String {
        case png,
             jpg,
             gif
    }
    
    enum Format: String {
        case json,
             src
    }
    
}
