//
//  SearchView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var vm: SearchViewModel
    
    @State private var mode = ImageScreenMode.grid
    @State private var image: AsyncImgView? = nil
    @State private var imageId: String? = nil
    
    private let colums: [GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
    ]
    
    var body: some View {
        VStack {
            switch (mode) {
            case .grid:
                getImageFullScreen()
                    .animation(.linear)
            case .fullScreen:
                getImageGridList()
            }
        }
    }
    
    private func getImageGridList() -> some View {
        ScrollView {
            LazyVGrid(columns: colums, spacing: 0) {
                ForEach(vm.images, id: \.imageId) { image in
                    VStack(spacing: 0) {
                        if let imageUrl = image.imageUrl {
                            AsyncImgView(imageUrl)
                                .frame(height: 120, alignment: .top)
                                .background(Color.black)
                                .border(Color.white, width: 1)
                                .onTapGesture {
                                    self.image = AsyncImgView(imageUrl)
                                    self.imageId = image.imageId
                                    toggleWithAnimation()
                                }
                        }
                    }
                }
            }
            Button(
                action: onClickGetMoreImagesButton,
                label: getMoreImagesBtnLabel
            )
        }
    }
    
    private func onClickGetMoreImagesButton() {
        vm.updateCurrentPage()
        vm.loadCurrentPage()
        vm.getImages()
    }
    
    private func getImageFullScreen() -> some View {
        ZStack {
            VStack {
                if let image = image {
                    image
                }
                if let imageId = imageId {
                    Button(
                        action: { vm.favouriteImage(imageId: imageId) },
                        label: getFavouriteBtnLabel)
                }
            }
        }
        .ignoresSafeArea()
        .onTapGesture(perform: dismissFullScreen)
    }
    
    private func dismissFullScreen() {
        self.image = nil
        self.imageId = nil
        toggleWithAnimation()
    }
    
    private func toggleWithAnimation() {
    }
    
    private func getMoreImagesBtnLabel() -> some View {
        Labels(text: "Get More Images")
            .padding(.horizontal)
    }
    
    enum ImageScreenMode {
        case grid, fullScreen
    }
    
    private func getFavouriteBtnLabel() -> some View {
        Image(systemName: "heart.fill")
            .resizable()
            .frame(width: 30, height: 30)
            .padding()
            .background(
                Color.black.opacity(0.3)
                    .cornerRadius(10)
            )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
