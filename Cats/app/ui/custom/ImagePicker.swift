//
//  ImagePicker.swift
//  Cats
//
//  Created by 김태호 on 2022/07/17.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller: PHPickerViewController = {
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 1
            configuration.filter = .images
            return PHPickerViewController(configuration: configuration)
        }()
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(
            _ picker: PHPickerViewController,
            didFinishPicking results: [PHPickerResult]
        ) {
            results.first?.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { image, err in
                if let err = err {
                    print(err.localizedDescription)
                }
                
                self.parent.selectedImage = image as? UIImage
                print(image.debugDescription)
            })
            picker.dismiss(animated: true)
        }
    }
}
