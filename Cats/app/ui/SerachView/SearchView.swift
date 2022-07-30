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
                ForEach(vm.images) { image in
                    if let url = image.url {
                        VStack(spacing: 0) {
                            AsyncImgView(url)
                                .frame(height: 120, alignment: .top)
                                .onTapGesture(perform: {
                                    self.image = AsyncImgView(url)
                                    toggleWithAnimation()
                                })
                        }
                        .background(Color.black)
                        .border(Color.white, width: 1)
                    }
                }
            }
        }
    }
    
    private func getImageFullScreen() -> some View {
        ZStack {
            if let image = image {
                image
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            self.image = nil
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
