//
//  UploadViewModel.swift
//  Cats
//
//  Created by 김태호 on 2022/07/16.
//

import Combine
import Foundation

class UploadViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    
    func uploadImage(image data: Data) {
        print("Preparing")
    }
}
