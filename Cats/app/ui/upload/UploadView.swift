//
//  UploadView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/16.
//

import SwiftUI

struct UploadView: View {
    @ObservedObject private var vm = UploadViewModel()
    
    @State private var showAlbum = false
    @State private var showCamera = false
    
    var body: some View {
        VStack(spacing: 0) {
            Image("cat-paw")
                .resizable()
                .scaledToFit()
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.accentColor)
                )
                .padding(.horizontal)
            Menu(
                content: {
                    UploadMenu.camera
                        .getButton(action: toggleCameraFullScreen)
                    UploadMenu.album
                        .getButton(action: toggleAlbumSheet)
                },
                label: getLabel
            )
            .padding(.vertical)
        }
        .sheet(
            isPresented: $showCamera,
            onDismiss: toggleCameraFullScreen,
            content: {}
        )
        .fullScreenCover(
            isPresented: $showAlbum,
            onDismiss: toggleAlbumSheet,
            content: {}
        )
    }
    
    private func toggleCameraFullScreen() {
        showCamera.toggle()
    }
    
    private func toggleAlbumSheet() {
        showCamera.toggle()
    }
    
    private func getLabel() -> some View {
        Labels(text: "Upload Cats", .black.opacity(0.3))
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
