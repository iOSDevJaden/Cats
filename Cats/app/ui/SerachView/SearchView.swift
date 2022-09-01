//
//  SearchView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var vm: SearchViewModel
    
    @State private var mode = SearchViewMode.grid
    
    private let colums: [GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
    ]
    
    var body: some View {
        VStack {
            switch mode {
            case .grid:       getGridImageView()
            case .fullScreen: getCandidateImage()
            }
        }
    }
    
    private func getGridImageView() -> some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: colums) {
                    ForEach(vm.images, id: \.imageId) { image in
                        AsyncImgView(image.imageUrl)
                            .onTapGesture {
                                vm.candidateImageUrl = image.imageUrl
                                toggleSearchMode()
                            }
                    }
                }
            }
            Button(
                action: onTapGetMoreImageButton,
                label: getMoreImagesButtonLabel)
        }
    }
    
    func onTapGetMoreImageButton() {
        vm.updateCurrentPage()
        vm.loadCurrentPage()
        vm.getImages()
    }
    
    private func getCandidateImage() -> some View {
        VStack {
            if let candidateImageUrl = vm.candidateImageUrl {
                AsyncImgView(candidateImageUrl)
                    .onTapGesture(perform: toggleSearchMode)
                Button(
                    action: {
                        vm.favouriteImage(imageUrl: candidateImageUrl)
                        toggleSearchMode()
                    },
                    label: {
                        Labels(text: "Like")
                            .padding()
                    })
            } else {
                EmptyView()
            }
        }
    }
    
    private func getMoreImagesButtonLabel() -> some View {
        Labels(text: "Get More Images")
            .padding(.horizontal)
    }
    
    private func toggleSearchMode() {
        withAnimation {
            self.mode = mode == .grid ? .fullScreen : .grid
        }
    }
    
    enum SearchViewMode {
        case grid, fullScreen
    }
}

struct SearchView_Previews: PreviewProvider {
    static private let vm = SearchViewModel()
    static var previews: some View {
        SearchView()
            .environmentObject(vm)
            .onAppear(perform: {
                vm.loadCurrentPage()
                vm.loadNumberOfImagePerPage()
                vm.getImages()
            })
    }
}
