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
                    Text("Camera")
                    Text("Album")
                },
                label: getLabel)
            .padding(.vertical)
        }
    }
    
    private func getLabel() -> some View {
        Labels(text: "Upload Cats", .black.opacity(0.3))
            .frame(width: 200)
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
