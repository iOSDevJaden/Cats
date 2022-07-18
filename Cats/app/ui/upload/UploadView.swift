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
                Button(action: {}, label: {
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
            
            // MARK: - sheet, fullScreenCover modifier do not work as expected.
            EmptyView()
                .sheet(
                    isPresented: $showAlbum,
                    content: {
                        PhotoPicker(selectedImage: $selectedImage)
                    })
            
            EmptyView()
                .fullScreenCover(
                    isPresented: $showCamera,
                    onDismiss: dismissCameraFullScreen,
                    content: {
                        Text("Camera")
                            .onTapGesture(perform: dismissCameraFullScreen)
                    }
                )
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

extension UploadView {
    enum UploadMenu {
        case album,
             camera
        
        private func getLabel() -> some View {
            switch self {
            case .album:  return Text("Album")
            case .camera: return Text("Camera")
            }
        }
        
        func getButton(action: @escaping () -> ()) -> some View {
            switch self {
            case .album:  return Button(action: action, label: getLabel)
            case .camera: return Button(action: action, label: getLabel)
            }
        }
    }
    
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
