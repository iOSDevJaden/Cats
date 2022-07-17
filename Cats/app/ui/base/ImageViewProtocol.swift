//
//  ImageViewProtocol.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import Foundation
import SwiftUI

protocol ImageViewProtocol {
    func getImage(imageUrl: String?) -> Image?
}

extension ImageViewProtocol {
    func getImage(imageUrl: String?) -> Image? {
        guard let imageUrl = imageUrl,
              let imageUrl = URL(string: imageUrl),
              // MARK: - Sync data...
              // TODO: - Need to make it async
              let imageData = try? Data(contentsOf: imageUrl),
              let uiImage = UIImage(data: imageData) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}
