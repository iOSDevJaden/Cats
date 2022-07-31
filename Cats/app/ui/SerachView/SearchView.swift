//
//  SearchView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var vm = SearchViewModel()
    @State private var showFullImage = false
    @State var image: AsyncImgView? = nil
    @State var imageId: String? = nil
    
    let colums: [GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
    ]
    
    var body: some View {
        VStack {
            if showFullImage {
                getImageFullScreen()
                    .animation(.linear)
            } else {
                getImageGridList()
            }
        }
        .onAppear(perform: vm.getImages)
    }
    
    private func getImageGridList() -> some View {
        ScrollView {
            LazyVGrid(columns: colums, spacing: 0) {
                ForEach(vm.images, id: \.imageId) { image in
                    VStack(spacing: 0) {
                        if let imageUrl = image.imageUrl {
                            AsyncImgView(imageUrl)
                                .frame(height: 120, alignment: .top)
                                .onTapGesture(perform: {
                                    self.image = AsyncImgView(imageUrl)
                                    self.imageId = image.imageId
                                    toggleWithAnimation()
                                })
                                .background(Color.black)
                                .border(Color.white, width: 1)
                        }
                    }
                }
            }
        }
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
                        label: {
                            Image(systemName: "heart.fill")
                        })
                }
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            self.image = nil
            self.imageId = nil
            toggleWithAnimation()
        }
    }
    
    private func toggleWithAnimation() {
        withAnimation { showFullImage.toggle() }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
