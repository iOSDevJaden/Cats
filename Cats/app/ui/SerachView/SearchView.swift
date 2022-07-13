//
//  SearchView.swift
//  Cats
//
//  Created by 김태호 on 2022/07/10.
//

import SwiftUI

struct SearchView: View, ImageViewProtocol {
    @ObservedObject private var vm = SearchViewModel()
    @State private var text = ""
    
    var body: some View {
        VStack {
            Text("Image")
                .font(.title)
            SearchBar($text)
            ForEach(vm.images) { image in
                if let image = getImage(imageUrl: image.url) {
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                }
            }
            Spacer()
        }
        .onAppear(perform: vm.getSingleImage)
        .navigationTitle("Search Image")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
