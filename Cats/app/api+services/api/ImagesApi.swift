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
        let parameters = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "mime_types", value: "jpg,png"),
            URLQueryItem(name: "size", value: "small"),
        ]
        
        return RequestBuilder()
            .setPath(path: "/images/search")
            .setMethod(method: .get)
            .setParameters(urlQuery: parameters)
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
    
    /** TODO: - Usaing of `multipart/form-data`
     * Create a new Iamge in the system
     * by uploading a valid .jpg or .png file containing a Cat
     */
    func getImageUpload(image: Data) -> URLRequest {
        let boundary = "----\(UUID().uuidString)\r\n"
        var headers: [String: String] = [:]
        headers["Content-Type"] = "multipart/form-data; boundary\(boundary)"
        
        return RequestBuilder()
            .setParameters(parameters: body)
            .setPath(path: "/images/upload")
            .setMethod(method: .post)
            .setHeaders(headers: headers)
            .build()
    }
}
