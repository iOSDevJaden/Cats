//
//  ImagesApi.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Foundation
import UIKit

struct ImagesApi {
    /**
     * Search & Itterate through all public images.
     */
    func getSingleImage() -> URLRequest {
        return RequestBuilder()
            .setPath(path: "/images/search")
            .setMethod(method: .get)
            .build()
    }
    
    func getAllPublicImages(limit: Int, page: Int = 0) -> URLRequest {
        let parameter = ImagesReq(
            size: .small,
            mimeTypes: [.jpg, .png],
            order: .asc,
            limit: limit,
            page: page,
            categoryIds: nil,
            format: .json,
            breedId: nil,
            breedsIncluded: false
        )
        
        return RequestBuilder()
            .setPath(path: "/images/search")
            .setMethod(method: .get)
            .setParameters(urlQuery: parameter.getUrlQueries())
            .build()
    }
    
    /**
     * Gets the image matching the image_id parameter passed.
     * If you are the owner then the full Image response will be present,
     * and any Vote or Favourite matching your account & sub_id will be attached.
     */
    func getImage(by id: String) -> URLRequest {
        return RequestBuilder()
            .setPath(path: "/images/\(id))")
            .setMethod(method: .get)
            .build()
    }
    
    func getImageUpload(image: Data) -> URLRequest {
        let boundary = "--\(UUID().uuidString)"
        
        let headers = [
            "Content-Type": "multipart/form-data; boundary=\(boundary)",
        ]
        
        let req = UploadImageReq(imageData: image)
        
        return RequestBuilder()
            .setParameters(parameters: req.getHttpBodyData(boundary: boundary))
            .setPath(path: "/images/upload")
            .setMethod(method: .post)
            .setHeaders(headers: headers)
            .build()
    }
}
