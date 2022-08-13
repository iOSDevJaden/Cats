//
//  ImagesApi.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Foundation
import UIKit

struct ImagesApi: BaseApiProtocol {
    /**
     * Search & Itterate through all public images.
     */
    func getSingleImage() -> URLRequest {
        return getCommonRequestBuilder()
            .addPath("/images")
            .addPath("/search")
            .setHttpMethod(.get)
            .build()
    }
    
    func getMultipleImages(limit: Int, page: Int = 0) -> URLRequest {
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
        
        return getCommonRequestBuilder()
            .addPath("/images")
            .addPath("/search")
            .setHttpMethod(.get)
            .setQueryItems(urlQueryItems: parameter.getUrlQueries())
            .build()
    }
    
    /**
     * Gets the image matching the image_id parameter passed.
     * If you are the owner then the full Image response will be present,
     * and any Vote or Favourite matching your account & sub_id will be attached.
     */
    func getImage(by id: String) -> URLRequest {
        return getCommonRequestBuilder()
            .setPath(path: "/images", id)
            .setHttpMethod(.get)
            .build()
    }
    
    func getImageUpload(image: Data) -> URLRequest {
        let boundary = "--\(UUID().uuidString)"
        
        let headers = [
            "Content-Type": "multipart/form-data; boundary=\(boundary)",
        ]
        
        let req = UploadImageReq(imageData: image)
        
        return getCommonRequestBuilder()
            .addPath("/images")
            .addPath("/upload")
            .setHeaders(headers: headers)
            .setHttpBody(httpBody: req.getHttpBodyData(boundary: boundary))
            .setHttpMethod(.post)
            .build()
    }
}
