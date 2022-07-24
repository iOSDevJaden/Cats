//
//  SearchView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var vm = SearchViewModel()
    
    let colums: [GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums, spacing: 0) {
                ForEach(vm.images) { image in
                    if let url = image.url {
                        VStack(spacing: 0) {
                            AsyncImgView(url)
                                .frame(height: 120, alignment: .top)
                            HStack {
                                Button(
                                    action: {
                                        guard let imageId = image.id else { return }
                                        vm.voteUpImage(image: imageId)
                                    },
                                    label: {
                                        Image(systemName: "hand.thumbsup")
                                            .foregroundColor(.accentColor)
                                    })
                                Spacer()
                                Button(
                                    action: { },
                                    label: {
                                        Image(systemName: "heart")
                                            .foregroundColor(.accentColor)
                                    })
                            }
                            .padding()
                        }
                        .background(Color.black)
                        .border(Color.white, width: 1)
                    }
                }
            }
            Button(
                action: vm.getMoreImages,
                label: { Text("Get More Images") })
        }
        .onAppear(perform: vm.getImages)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
