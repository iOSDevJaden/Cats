//
//  UploadImageReq.swift
//  Cats
//
//  Created by 김태호 on 2022/07/22.
//

import Foundation

struct UploadImageReq: Codable {
    let imageData: Data
    let subId: String
    
    private var httpBody = Data()
    
    init(imageData: Data, subId: String = UserInfoCache.shared.id) {
        self.imageData = imageData
        self.subId = subId
    }
    
    func getHttpBodyData(boundary: String) -> Data {
        var data = Data()
        
        if let boundaryData = "--\(boundary)\r\n".data(using: .utf8) {
            data.append(boundaryData)
        }
        
        if let contentDisposition = "Content-Disposition: form-data; name=\"file\"; filename=\"\(UUID().uuidString).jpeg\"\r\n".data(using: .utf8) {
            data.append(contentDisposition)
        }
        
        if let contentType = "Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) {
            data.append(contentType)
        }
        
        data.append(imageData)
        print("Image Data = \(imageData.isEmpty ? "No data": "Image Data")")

        if let boundaryData = "\r\n--\(boundary)--".data(using: .utf8) {
            data.append(boundaryData)
        }

        if let contentDisposition = "Content-Disposition: form-data; name=\"sub_id\"\r\n\(subId)\r\n".data(using: .utf8) {
            data.append(contentDisposition)
        }

        if let boundaryData = "--\(boundary)--".data(using: .utf8) {
            data.append(boundaryData)
        }
        return data
    }
}
