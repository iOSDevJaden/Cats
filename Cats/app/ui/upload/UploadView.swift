//
//  UploadView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/16.
//

import SwiftUI
import PhotosUI

struct UploadView: View {
    @ObservedObject private var vm = UploadViewModel()
    @State private var selectedImage: UIImage?
    
    @State private var showActionSheet = false
    @State private var showAlbum = false
    @State private var showCamera = false
    
    var body: some View {
        VStack(spacing: 0) {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.accentColor)
                    )
                    .padding(.horizontal)
            } else {
                Image("cat-paw")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.accentColor)
                    )
                    .padding(.horizontal)
            }
            if selectedImage != nil {
                Button(
                    action: {
                        vm.uploadImage(imageData: selectedImage?.jpegData(compressionQuality: 0.2))
                    },
                    label: {
                        Labels(text: "Upload", .green.opacity(0.3))
                            .frame(width: 200)
                    })
                .padding(.vertical)
            } else {
                Button(
                    action: toggleActionSheet,
                    label: getLabel)
                .padding(.vertical)
            }
            
        }
        .onAppear(perform: requestPermission)
        .actionSheet(
            isPresented: $showActionSheet,
            content: {
                ActionSheet(
                    title: Text("Select"),
                    buttons: [
                        .cancel(),
                        .default(Text("Album"), action: showAlbumSheet),
                        .default(Text("Camera"), action: showCameraFullScreen),
                    ]
                )
            })
        /* MARK: - sheet, fullScreenCover modifier do not work as expected.
         * iOS Simulator did not show sheet or full screen cover.
         * However, it works fine in the real device. */
        .sheet(
            isPresented: $showAlbum,
            content: {
                PhotoPicker(selectedImage: $selectedImage)
            })
        .fullScreenCover(
            isPresented: $showCamera,
            onDismiss: dismissCameraFullScreen,
            content: {
                Text("Camera")
                    .onTapGesture(perform: dismissCameraFullScreen)
            }
        )
    }
    
    private func requestPermission() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .authorized: print("Authorized")
            default:          print("Not authorized")
            }
        }
    }
    
    private func toggleActionSheet() {
        showActionSheet.toggle()
    }
    
    private func showCameraFullScreen() {
        showCamera = true
    }
    
    private func showAlbumSheet() {
        showAlbum = true
    }
    
    private func dismissCameraFullScreen() {
        showCamera = false
    }
    
    private func dismissAlbumSheet() {
        showAlbum = false
    }
    
    private func getLabel() -> some View {
        Labels(text: "Select picture", .black.opacity(0.3))
            .frame(width: 200)
    }
}

fileprivate struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.accentColor)
            )
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
