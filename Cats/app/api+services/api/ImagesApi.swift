//
//  ImagesApi.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Foundation

struct ImagesApi {
    
    func getAllPublicImages() -> URLRequest {
        var request = URLRequest.getRelativePath("/images/search")
        request.httpMethod = HttpMethod.getValue(method: .get)
        
        return request
    }
    /**
     * Gets the image matching the image_id parameter passed.
     * If you are the owner then the full Image response will be present,
     * and any Vote or Favourite matching your account & sub_id will be attached.
     */
    func getImage(by id: String) -> URLRequest {
        var request = URLRequest.getRelativePath("/images/\(id))")
        request.httpMethod = HttpMethod.getValue(method: .get)
        
        return request
    }
}
