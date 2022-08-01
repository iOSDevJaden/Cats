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
    
    func uploadImage(imageData: Data?) {
        guard let imageData = imageData else {
            return
        }
        
        ImagesService().uploadImage(image: imageData)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: {
                    print($0)
                },
                receiveValue: {
                    print("\($0 ? "Success" : "Failed")")
                })
            .store(in: &cancellable)
    }
}
