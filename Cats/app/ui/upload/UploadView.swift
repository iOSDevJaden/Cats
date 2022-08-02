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
    
    private var actionSheetBtns: [ActionSheet.Button] {
        let cancelBtn = ActionSheet.Button.cancel()
        let albumBtn = ActionSheet.Button
            .default(Text("Album"),
                     action: showAlbumSheetToggle)
        let cameraBtn = ActionSheet.Button
            .default(Text("Camera"),
                     action: showCameraFullScreenToggle)
        return [
            cancelBtn, albumBtn,
            cameraBtn
        ]
    }
    
    private let placeHolderImage = Image("cat-paw")
    
    private func getSelectPictureBtn() -> some View {
        Button(
            action: toggleActionSheet,
            label: getSelectPictureBtnLabel)
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            getSelectedImage(selected: selectedImage)
                .resizable()
                .scaledToFit()
                .modifier(ImageModifier())
                .padding()
            
            if let selectedImage = selectedImage {
                getUploadPictureBtn(selected: selectedImage)
                    .padding(.vertical)
            } else {
                getSelectPictureBtn()
                    .padding(.vertical)
            }
            
        }
        .onAppear(perform: requestPermission)
        .actionSheet(
            isPresented: $showActionSheet,
            content: getActionSheet)
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
            content: {
                Text("Camera")
                    .onTapGesture(perform: showCameraFullScreenToggle)
            }
        )
    }
    
    private func getSelectedImage(selected image: UIImage?) -> Image {
        guard let uiImage = image else {
            return placeHolderImage
        }
        return Image(uiImage: uiImage)
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
    
    private func showCameraFullScreenToggle() {
        showCamera.toggle()
    }
    
    private func showAlbumSheetToggle() {
        showAlbum.toggle()
    }
    
    private func getUploadPictureBtn(selected image: UIImage) -> some View {
        Button(
            action: {
                vm.uploadImage(
                    imageData: image.jpegData(compressionQuality: 0.2)
                )
            },
            label: getUploadPictureBtnLabel)
    }
    
    private func getActionSheet() -> ActionSheet {
        ActionSheet(
            title: Text("Select"),
            buttons: actionSheetBtns)
    }
    
    private func getUploadPictureBtnLabel() -> some View {
        Labels(text: "Upload", .green.opacity(0.3))
            .frame(width: 200)
    }
    
    private func getSelectPictureBtnLabel() -> some View {
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
