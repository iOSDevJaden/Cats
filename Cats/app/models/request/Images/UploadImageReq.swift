//
//  UploadImageReq.swift
//  Cats
//
//  Created by 김태호 on 2022/07/22.
//

import Foundation

struct UploadImageReq: Codable {
    let file: Data
    let subId: String
}
